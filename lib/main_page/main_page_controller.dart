import 'dart:convert';
import 'dart:io';


import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:just_audio/just_audio.dart';


import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:dio/dio.dart' as d;
import 'package:string_similarity/string_similarity.dart';
import 'package:test_speak/main_page/main_page_state.dart';
import 'package:test_speak/match_room/models/match_room_model.dart';
import 'package:test_speak/push.dart';
import 'package:test_speak/util/apis.dart';
import 'package:test_speak/util/dia_helper.dart';
import 'package:translator/translator.dart';

class MainPageController extends GetxController {
  final state = MainPageState();

  void changeListenState(bool newValue) {
    state.isListening = newValue;
    update();
  }

  void actionsManager()async{
    if (state.speaking) {
       await state.flutterTts.stop();
        changeSpeakingState(false);

    }
    if (strrtV.value) {
      await stopMethod();
    }
    startListen();
    // speak('اهلا');
    // playMethod('${photoAPI}room_l/o7sYqoWx16u1lPz8a0hULpkmFwjCDomSmO2rQkpX.webm');
  }

  void startListen() async {
    if (state.isListening) {
      // await Future.delayed(Duration(seconds: 2));
      await state.speech.cancel();
      changeListenState(false);

      // speaker(state.text);

      update();
      // print(state.text.toString() + "d");
      if (state.text.isNotEmpty) {
        choiceSelector(state.text);
      }
    } else {
       await state.speech.initialize(
                onStatus: (val)async{
                 if(val=='done'){
                   await state.speech.cancel();
                   changeListenState(false);

                   // if()

                   // speaker(state.text);



                   update();
                   // print(state.text.toString() + "d");
                   if (state.text.isNotEmpty) {
                     // choiceSelector(state.text);
                     if(state.text=='الخروج'){
                       if(Platform.isIOS){
                         exit(0);
                       }else{
                         SystemNavigator.pop();
                       }
                     }else{
                       choiceSelector(state.text);
                     }
                   }
                 }

                },
          onError: (val) => print('onError: $val'),
    );
      
     state.speech.listen(
        localeId: 'ar',
        onResult: (val) {
          // print(val.recognizedWords+"k");
          // state.text = val.recognizedWords;
            if(val.recognizedWords.isEmpty){
              state.text='';
            }else{
              state.text = val.recognizedWords;
            }

          if (val.hasConfidenceRating && val.confidence > 0) {
            state.confidence = val.confidence;
          }
        },
      );
      changeListenState(true);
      
    }
  }

  Future<void> newPusher() async {
    PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
          apiKey: key,
          cluster: cluster,
          onConnectionStateChange: (String? c, String? v) {},
          onError: (String? v, int? a, dynamic b) {},
          onSubscriptionSucceeded: (String? c, dynamic b) {},
          onEvent: (event) {
            // print(jsonDecode(event.data.toString()));

            if (event.eventName != 'pusher:pong') {
              var formatedData = jsonDecode(event.data);
              // var id = MyDataBase.getId();
              print(event.eventName);
              // print(formatedData);

              if (event.eventName.contains('match_e')) {
                if(formatedData['id']==state.currentid!&&formatedData['code']==state.currentCode){
                  sendRequest(id: state.currentid!, code: state.currentCode!);
                }
              }


            }
          });
      await pusher.subscribe(channelName: 'v');
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }




  Future speak(String t) async {
    if (Platform.isIOS) {
      await state.flutterTts.setSharedInstance(true);
    }
    changeSpeakingState(true);
    state.flutterTts.setLanguage('ar');
    state.flutterTts.setVolume(1);
    // state.flutterTts.setVoice({'locale': 'ar-001', 'name': 'Majed'});
    await state.flutterTts.awaitSpeakCompletion(true);
    await state.flutterTts.speak(t);
    changeSpeakingState(false);
  }

  void changeSpeakingState(bool value) {
    state.speaking = value;
  }

  Future<void> sendStartMethod() async {
    d.Response response = await DioHelper.postMethod(
      url: searchAPI,
      data: {'code': 'start', 'id': '0'},
    );
    if (response.data['status']) {
      state.matchRoomModel = MatchRoomModel.fromJson(response.data);

      await speak(state.matchRoomModel.msg!);
    }
  }

  Future<void> sendRequest({required String id, required String code}) async {
    d.Response response = await DioHelper.postMethod(
      url: searchAPI,
      data: {'code': code, 'id': id},
    );
    if (response.data['status']) {
      state.matchRoomModel = MatchRoomModel.fromJson(response.data);
      print(state.matchRoomModel.options!);

      await speak(state.matchRoomModel.msg!);
      // print(state.matchRoomModel.room!.id);
       if (state.matchRoomModel.room != null) {
        if (state.matchRoomModel.room!.type == 1) {
          await setUrl('$photoAPI${state.matchRoomModel.room!.text!}');
          print('$photoAPI${state.matchRoomModel.room!.text!}');
          await playMethod('$photoAPI${state.matchRoomModel.room!.text!}');
        } else {
          await speak(state.matchRoomModel.room!.text!);
        }
      }
    }
  }

  // choiceSelector(String s) async {
  //   for (var i = 0; i < state.matchRoomModel.options!.length; i++) {
  //     var result = state.matchRoomModel.options![i].name!.similarityTo(s);
  //     print(s);
  //     print(state.matchRoomModel.options![i].name!);
  //     print(result);
  //
  //     if (result > 0.5) {
  //       // print(s);
  //
  //       await speak('تعرفت على هذا وجارى البحث عن اختيارك');
  //        sendRequest(
  //           id: state.matchRoomModel.options![i].id!.toString(),
  //           code: state.matchRoomModel.options![i].code!,
  //         );
  //
  //
  //       return 'done';
  //     }
  //   }
  //   speak(' عذرا لم اتعرف على هذا اعد المحاولة');
  // }
  choiceSelector(String s) async {
    final translator = GoogleTranslator();
    var translation2 =
    await translator.translate(s.toString(), to: 'en');

    for (var i = 0; i < state.matchRoomModel.options!.length; i++) {
      var translation =
      await translator.translate(state.matchRoomModel.options![i].name!.toString(), to: 'en');
      var result = translation2.toString().toLowerCase().contains(translation.toString().toLowerCase());
      print(result);
      print(state.matchRoomModel.options![i].name!.toString());
      print(translation2);
      print(translation);
      if (result) {
        // print(s);

        await speak('تعرفت على هذا وجارى البحث عن اختيارك');
        state.currentCode=state.matchRoomModel.options![i].code!;
        state.currentid=state.matchRoomModel.options![i].id!.toString();
        sendRequest(
            id: state.matchRoomModel.options![i].id!.toString(),
            code: state.matchRoomModel.options![i].code!);
        return 'done';
      }
    }
    speak(' عذرا لم اتعرف على هذا اعد المحاولة');
  }

  Future<void> getRoom({required String id, required String code}) async {
    d.Response response = await DioHelper.postMethod(
      url: searchAPI,
      data: {'code': code, 'id': id},
    );
    if (response.data['status']) {
      state.matchRoomModel = MatchRoomModel.fromJson(response.data);
      print(state.matchRoomModel.options!);
      for (var i = 0; i < state.matchRoomModel.options!.length; i++) {
        print(state.matchRoomModel.options![i].name);
      }

      await speak(state.matchRoomModel.msg!);
      if (state.matchRoomModel.room != null) {
        if (state.matchRoomModel.room!.type == 1) {
          await setUrl('$photoAPI${state.matchRoomModel.room!.text!}');
          print('$photoAPI${state.matchRoomModel.room!.text!}');
          await playMethod('$photoAPI${state.matchRoomModel.room!.text!}');
        } else {
          await speak(state.matchRoomModel.room!.text!);
        }
      }
    }
  }

  
  final player=AudioPlayer();

  RxBool strrtV = false.obs;
  Future<void> setUrl(String url) async {
    // print(widget.url);
    await player.setUrl(url);
    // print(duration);
  }

  Future<void> playMethod(String url) async {
    strrtV.value = true;
    print(url);
    // var result = await palayer.play();
    // Source s=Source
    await setUrl(url);
    await player.play();
    print('object');
    strrtV.value = false;
  }

  Future<void> stopMethod() async {
    // await player.pause();
    strrtV.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  
    sendStartMethod();
    newPusher();
    state.speech = stt.SpeechToText();
    // print(state.flutterTts.getVoices);
    // testing();
  }

  void testing() async {
    print(await state.flutterTts.getVoices);
  }
}
