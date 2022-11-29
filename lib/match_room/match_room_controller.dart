// import 'dart:io';
//
// import 'package:get/get.dart';
// import 'package:ma3n/match_room/match_room_state.dart';
// import 'package:dio/dio.dart'as d;
// import 'package:ma3n/match_room/models/match_room_model.dart';
// import 'package:ma3n/util/apis.dart';
// import 'package:ma3n/util/dia_helper.dart';
// class MatchRoomController extends GetxController{
//   final state=MatchRoomState();
//   late String id;
//   late String code;
//   MatchRoomController({required this.id,required this. code});
//
//  Future<void> getRoom() async {
//     d.Response response = await DioHelper.postMethod(
//       url: searchAPI,
//       data: {'code': code, 'id': id},
//     );
//     if (response.data['status']) {
//       state.matchRoomModel = MatchRoomModel.fromJson(response.data);
//       print(state.matchRoomModel.options!);
//       for (var i = 0; i < state.matchRoomModel.options!.length; i++) {
//         print(state.matchRoomModel.options![i].name);
//       }
//
//       await speak(state.matchRoomModel.msg!);
//     }
//   }
//    Future speak(String t) async {
//
// if (Platform.isIOS) {
//   await state.flutterTts.setSharedInstance(true);
// }
//     changeSpeakingState();
//     state.flutterTts.setLanguage('ar');
//     state.flutterTts.setVolume(1);
//     await state.flutterTts.awaitSpeakCompletion(true);
//     await state.flutterTts.speak(t);
//     changeSpeakingState();
//   }
//     void changeSpeakingState() {
//     state.speaking = !state.speaking;
//   }
//
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     getRoom();
//   }
// }