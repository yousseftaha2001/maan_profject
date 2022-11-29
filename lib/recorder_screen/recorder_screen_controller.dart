// import 'package:get/get_state_manager/get_state_manager.dart';
//
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// class RecorderScrrenController extends GetxController {
//   final RecorderState state = RecorderState();
//
//   // void changeIsListenning() {
//   //   state.isListening = !state.isListening;
//   //   state.va = !state.va;
//   //   print(state.isListening);
//   //   update();
//   // }
//
//   // listen() async {
//   //   if (!state.isListening) {
//   //     bool available = await state.speech!.initialize(
//   //       onStatus: (val) => print('onStatus: $val'),
//   //       onError: (val) => print('onError: $val'),
//   //     );
//
//   //     changeIsListenning();
//   //     state.speech!.listen(
//   //       onResult: (result) {
//   //         // print(result.recognizedWords);
//   //         // state.text.value = result.recognizedWords;
//   //         // // state.tts.speak(state.text.value);
//
//   //         // if (result.hasConfidenceRating && result.confidence > 0) {
//   //         //   state.confidence.value = result.confidence;
//   //         // }
//   //       },
//   //     ).then(
//   //       (value) {
//   //        state.text.value=value;
//   //       },
//   //     );
//   //   } else {
//   //     changeIsListenning();
//   //     state.speech!.stop();
//   //      state.flutterTts.setLanguage('ar');
//   //     state.flutterTts.speak(state.text.value);
//
//   //   }
//   // }
//
//   // void getL() async {
//   //   List<dynamic> languages = await state.flutterTts.getLanguages;
//   //   print(languages);
//   // }
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     //     _speech = stt.SpeechToText();
//     state.speech=stt.SpeechToText();
//     // getL();
//   }
// }
