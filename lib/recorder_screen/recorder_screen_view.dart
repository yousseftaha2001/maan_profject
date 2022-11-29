// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_siri_suggestions/flutter_siri_suggestions.dart';
// import 'package:get/get.dart';
// import 'package:highlight_text/highlight_text.dart';
// import 'package:ma3n/recorder_screen/recorder_screen_controller.dart';
// import 'package:ma3n/recorder_screen/recorder_screen_state.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class RecorderScreen extends StatefulWidget {
//   const RecorderScreen({super.key});

//   @override
//   State<RecorderScreen> createState() => _RecorderScreenState();
// }

// class _RecorderScreenState extends State<RecorderScreen> {
//   final RecorderScrrenController controller =
//       Get.put(RecorderScrrenController());
//   final RecorderState state = Get.find<RecorderScrrenController>().state;
//   SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _lastWords = '';

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//     initSuggestions();
//   }

//   /// This has to happen only once per app
//   void _initSpeech() async {
//     _speechEnabled = await _speechToText.initialize();
//     setState(() {});
//   }

//   /// Each time to start a speech recognition session
//   void _startListening() async {
    
//     await _speechToText.listen(onResult: _onSpeechResult,localeId: 'ar');
  
//     setState(() {});
//   }

//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }
//    String _text = 'added mainActivity, beerActivity suggestions 🙋‍♂️';

//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _lastWords = result.recognizedWords;
//     });
//   }
//    void initSuggestions() async {
//     FlutterSiriSuggestions.instance.configure(
//         onLaunch: (Map<String, dynamic> message) async {
//       debugPrint('[FlutterSiriSuggestions] [onLaunch] $message');
//       //Awaken from Siri Suggestion
//       ///// TO DO : do something!
//       String __text;

//       debugPrint(
//           "[FlutterSiriSuggestions] Called by ${message['key']} suggestion.");

//       switch (message["key"]) {
//         case "mainActivity":
//           __text = "redirect to mainActivity";
//           break;
//         case "beerActivity":
//           __text = "redirect to beerActivity";
//           break;
//         case "searchActivity":
//           __text = "redirect to searchActivity";
//           break;
//         case "talkActivity":
//           __text = "redirect to talkActivity";
//           break;
//         default:
//           __text = "hmmmm...... made a typo";
//       }

//       setState(() {
//         _text = __text;
//       });
//     });

    

//     await FlutterSiriSuggestions.instance.registerActivity(
//         const FlutterSiriActivity("mainActivity Suggestion", "mainActivity",
//             isEligibleForSearch: true,
//             isEligibleForPrediction: true,
//             contentDescription: "Open mainActivity",
//             suggestedInvocationPhrase: "open my app",
//             userInfo: {"info": "sample"}));

//     await FlutterSiriSuggestions.instance
//         .registerActivity(const FlutterSiriActivity(
//       "beerActivity Suggestion",
//       "beerActivity",
//       isEligibleForSearch: true,
//       isEligibleForPrediction: true,
//       contentDescription: "Open beerActivity 🍺",
//       suggestedInvocationPhrase: "coooooool",
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             'Confidence: ${(state.confidence.value * 100.0).toStringAsFixed(1)}%'),
//       ),

//       // floatingActionButton: AvatarGlow(
//       //   animate: state.isListening.value,
//       //   glowColor: Theme.of(context).primaryColor,
//       //   endRadius: 75.0,
//       //   duration: const Duration(milliseconds: 2000),
//       //   repeatPauseDuration: const Duration(milliseconds: 100),
//       //   repeat: true,
//       //   child: FloatingActionButton(
//       //     onPressed: controller.listen,
//       //     child: Icon(state.isListening.value ? Icons.mic : Icons.mic_none),
//       //   ),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//              TextButton(
//                       child: const Text(
//                         "add searchActivity Suggestion\n(key: searchActivity)",
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       onPressed: () async {
//                         FlutterSiriSuggestionsResult result =
//                             await FlutterSiriSuggestions.instance
//                                 .registerActivity(const FlutterSiriActivity(
//                           "searchActivity Suggestion",
//                           "searchActivity",
//                           isEligibleForSearch: true,
//                           isEligibleForPrediction: true,
//                           contentDescription: "Open searchActivity 🧐",
//                           suggestedInvocationPhrase: "Search",
//                         ));
//                         print(result.key);

//                         // showSnackBar(
//                         //     "${result.key} suggestion added.\n(key: ${result.key}, persistentIdentifier: ${result.persistentIdentifier})",
//                         //     context: context);
//                       },
//                     ),
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: const Text(
//                 'Recognized words:',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   // If listening is active show the recognized words
//                   _speechToText.isListening
//                       ? '$_lastWords'
//                       // If listening isn't active but could be tell the user
//                       // how to start it, otherwise indicate that speech
//                       // recognition is not yet ready or not supported on
//                       // the target device
//                       : _speechEnabled
//                           ? 'Tap the microphone to start listening...'
//                           : 'Speech not available',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed:
//             // If not yet listening for speech start, otherwise stop
//             _speechToText.isNotListening ? _startListening : _stopListening,
//         tooltip: 'Listen',
//         child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//       ),
//     );
//   }
// }
