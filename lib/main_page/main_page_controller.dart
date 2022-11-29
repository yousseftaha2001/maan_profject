import 'dart:io';


import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:just_audio/just_audio.dart';


import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:dio/dio.dart' as d;
import 'package:string_similarity/string_similarity.dart';
import 'package:test_speak/main_page/main_page_state.dart';
import 'package:test_speak/match_room/models/match_room_model.dart';
import 'package:test_speak/util/apis.dart';
import 'package:test_speak/util/dia_helper.dart';

class MainPageController extends GetxController {
  final state = MainPageState();

  void changeListenState(bool newValue) {
    state.isListening = newValue;
    update();
  }

  void actionsManager()async{
    // if (state.speaking) {
    //    await state.flutterTts.stop();
    //     changeSpeakingState(false);
    // 
    // }
    // if (strrtV.value) {
    //   await stopMethod();
    // }
    // startListen();
    playMethod('${photoAPI}room_l/o7sYqoWx16u1lPz8a0hULpkmFwjCDomSmO2rQkpX.webm');
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
                onStatus: (val){
                  print(val);
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

  // void listen() async {
  //   // state.text='';
  //   if (state.speaking == false || strrtV.value == false) {
  //     if (!state.isListening) {
  //       bool available = await state.speech.initialize(
  //         onStatus: (val) => print('onStatus: $val'),
  //         onError: (val) => print('onError: $val'),
  //       );
  //       if (available) {
  //         state.isListening = true;
  //         update();

  //         state.speech.listen(
  //           localeId: 'ar',
  //           onResult: (val) {
  //             // print(val.recognizedWords+"k");
  //             // state.text = val.recognizedWords;
  //             if (val.confidence > 0.6) {
  //               state.text = val.recognizedWords;
  //             }

  //             if (val.hasConfidenceRating && val.confidence > 0) {
  //               state.confidence = val.confidence;
  //             }
  //           },
  //         );
  //       }
  //     } else {
  //       await state.speech.stop();
  //       state.isListening = false;

  //       // speaker(state.text);

  //       update();
  //       // print(state.text.toString() + "d");
  //       if (state.text.isNotEmpty) {
  //         choiceSelector(state.text);
  //       }
  //     }
  //   } else {
  //     changeSpeakingState();
  //     state.flutterTts.stop();
  //     await stopMethod();
  //     listen();
  //   }
  // }

  Future speak(String t) async {
    if (Platform.isIOS) {
      await state.flutterTts.setSharedInstance(true);
    }
    changeSpeakingState(true);
    state.flutterTts.setLanguage('ar');
    state.flutterTts.setVolume(1);
    state.flutterTts.setVoice({'locale': 'ar-001', 'name': 'Majed'});
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
      print(state.matchRoomModel.room!.id);
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

  choiceSelector(String s) async {
    for (var i = 0; i < state.matchRoomModel.options!.length; i++) {
      var result = state.matchRoomModel.options![i].name!.similarityTo(s);
      print(s);
      print(state.matchRoomModel.options![i].name!);
      print(result);

      if (result > 0.5) {
        // print(s);

        await speak('تعرفت على هذا وجارى البحث عن اختيارك');
         sendRequest(
            id: state.matchRoomModel.options![i].id!.toString(),
            code: state.matchRoomModel.options![i].code!,
          );
       
        // if (state.matchRoomModel.options![i].code != 'A1311' ||
        //     state.matchRoomModel.options![i].code != 'B1311') {
        //   sendRequest(
        //     id: state.matchRoomModel.options![i].id!.toString(),
        //     code: state.matchRoomModel.options![i].code!,
        //   );
        // } else {
        //   print("going to match room");
        //   getRoom(
        //     id: state.matchRoomModel.options![i].id!.toString(),
        //     code: state.matchRoomModel.options![i].code!,
        //   );
        // }
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
  
    // sendStartMethod();
    state.speech = stt.SpeechToText();
    // print(state.flutterTts.getVoices);
    // testing();
  }

  void testing() async {
    print(await state.flutterTts.getVoices);
  }
}
