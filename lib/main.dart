import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_speak/util/dia_helper.dart';

import 'main_page/main_page.dart';
import 'recorder_screen/recorder_screen_view.dart';

void main() {
   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home: const MainPage(),
        );
      }
    );
  }
}
//
//
// // import 'package:avatar_glow/avatar_glow.dart';
// // import 'package:flutter/material.dart';
// // import 'package:highlight_text/highlight_text.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
//
// // void main() {
// //   runApp(MyApp());
// // }
//
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Voice',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.red,
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: SpeechScreen(),
// //     );
// //   }
// // }
//
// // class SpeechScreen extends StatefulWidget {
// //   @override
// //   _SpeechScreenState createState() => _SpeechScreenState();
// // }
//
// // class _SpeechScreenState extends State<SpeechScreen> {
// //   final Map<String, HighlightedWord> _highlights = {
// //     'flutter': HighlightedWord(
// //       onTap: () => print('flutter'),
// //       textStyle: const TextStyle(
// //         color: Colors.blue,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //     'voice': HighlightedWord(
// //       onTap: () => print('voice'),
// //       textStyle: const TextStyle(
// //         color: Colors.green,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //     'subscribe': HighlightedWord(
// //       onTap: () => print('subscribe'),
// //       textStyle: const TextStyle(
// //         color: Colors.red,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //     'like': HighlightedWord(
// //       onTap: () => print('like'),
// //       textStyle: const TextStyle(
// //         color: Colors.blueAccent,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //     'comment': HighlightedWord(
// //       onTap: () => print('comment'),
// //       textStyle: const TextStyle(
// //         color: Colors.green,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //   };
//
// //   late stt.SpeechToText _speech;
// //   bool _isListening = false;
// //   String _text = 'Press the button and start speaking';
// //   double _confidence = 1.0;
//
// //   @override
// //   void initState() {
// //     super.initState();
// //     _speech = stt.SpeechToText();
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// //       floatingActionButton: AvatarGlow(
// //         animate: _isListening,
// //         glowColor: Theme.of(context).primaryColor,
// //         endRadius: 75.0,
// //         duration: const Duration(milliseconds: 2000),
// //         repeatPauseDuration: const Duration(milliseconds: 100),
// //         repeat: true,
// //         child: InkWell(
// //           onLongPress:_listen,
// //           child: Icon(_isListening ? Icons.mic : Icons.mic_none),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         reverse: true,
// //         child: Container(
// //           padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
// //           child: TextHighlight(
// //             text: _text,
// //             words: _highlights,
// //             textStyle: const TextStyle(
// //               fontSize: 32.0,
// //               color: Colors.black,
// //               fontWeight: FontWeight.w400,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // Locale g= Locale("ar");
// //   void _listen() async {
// //     if (!_isListening) {
// //       bool available = await _speech.initialize(
// //         onStatus: (val) => print('onStatus: $val'),
// //         onError: (val) => print('onError: $val'),
// //       );
// //       if (available) {
// //         setState(() => _isListening = true);
// //         _speech.listen(
// //           localeId: g.toLanguageTag(),
// //           onResult: (val) => setState(() {
// //             _text = val.recognizedWords;
// //             print(_text);
// //             if (val.hasConfidenceRating && val.confidence > 0) {
// //               _confidence = val.confidence;
// //               print(val.confidence);
// //             }
// //           }),
// //         );
// //       }
// //     } else {
// //       setState(() => _isListening = false);
// //       _speech.stop();
// //     }
// //   }
// // }
// import 'dart:async';
// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart' show kIsWeb;
//
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// enum TtsState { playing, stopped, paused, continued }
//
// class _MyAppState extends State<MyApp> {
//   late FlutterTts flutterTts;
//   String? language;
//   String? engine;
//   double volume = 0.5;
//   double pitch = 1.0;
//   double rate = 0.5;
//   bool isCurrentLanguageInstalled = false;
//
//   String? _newVoiceText;
//   int? _inputLength;
//
//   TtsState ttsState = TtsState.stopped;
//
//   get isPlaying => ttsState == TtsState.playing;
//   get isStopped => ttsState == TtsState.stopped;
//   get isPaused => ttsState == TtsState.paused;
//   get isContinued => ttsState == TtsState.continued;
//
//   bool get isIOS => !kIsWeb && Platform.isIOS;
//   bool get isAndroid => !kIsWeb && Platform.isAndroid;
//   bool get isWindows => !kIsWeb && Platform.isWindows;
//   bool get isWeb => kIsWeb;
//
//   @override
//   initState() {
//     super.initState();
//     initTts();
//   }
//
//   initTts() {
//     flutterTts = FlutterTts();
//
//     _setAwaitOptions();
//
//     if (isAndroid) {
//       _getDefaultEngine();
//       _getDefaultVoice();
//     }
//
//     flutterTts.setStartHandler(() {
//       setState(() {
//         print("Playing");
//         ttsState = TtsState.playing;
//       });
//     });
//
//     if (isAndroid) {
//       flutterTts.setInitHandler(() {
//         setState(() {
//           print("TTS Initialized");
//         });
//       });
//     }
//
//     flutterTts.setCompletionHandler(() {
//       setState(() {
//         print("Complete");
//         ttsState = TtsState.stopped;
//       });
//     });
//
//     flutterTts.setCancelHandler(() {
//       setState(() {
//         print("Cancel");
//         ttsState = TtsState.stopped;
//       });
//     });
//
//     flutterTts.setPauseHandler(() {
//       setState(() {
//         print("Paused");
//         ttsState = TtsState.paused;
//       });
//     });
//
//     flutterTts.setContinueHandler(() {
//       setState(() {
//         print("Continued");
//         ttsState = TtsState.continued;
//       });
//     });
//
//     flutterTts.setErrorHandler((msg) {
//       setState(() {
//         print("error: $msg");
//         ttsState = TtsState.stopped;
//       });
//     });
//   }
//
//   Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;
//
//   Future<dynamic> _getEngines() async => await flutterTts.getEngines;
//
//   Future _getDefaultEngine() async {
//     var engine = await flutterTts.getDefaultEngine;
//     if (engine != null) {
//       print(engine);
//     }
//   }
//
//   Future _getDefaultVoice() async {
//     var voice = await flutterTts.getDefaultVoice;
//     if (voice != null) {
//       print(voice);
//     }
//   }
//
//   Future _speak() async {
//     await flutterTts.setVolume(volume);
//     await flutterTts.setSpeechRate(rate);
//     await flutterTts.setPitch(pitch);
//
//     if (_newVoiceText != null) {
//       if (_newVoiceText!.isNotEmpty) {
//         await flutterTts.speak(_newVoiceText!);
//       }
//     }
//   }
//
//   Future _setAwaitOptions() async {
//     await flutterTts.awaitSpeakCompletion(true);
//   }
//
//   Future _stop() async {
//     var result = await flutterTts.stop();
//     if (result == 1) setState(() => ttsState = TtsState.stopped);
//   }
//
//   Future _pause() async {
//     var result = await flutterTts.pause();
//     if (result == 1) setState(() => ttsState = TtsState.paused);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     flutterTts.stop();
//   }
//
//   List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
//     var items = <DropdownMenuItem<String>>[];
//     for (dynamic type in engines) {
//       items.add(DropdownMenuItem(
//           value: type as String?, child: Text(type as String)));
//     }
//     return items;
//   }
//
//   void changedEnginesDropDownItem(String? selectedEngine) async {
//     await flutterTts.setEngine(selectedEngine!);
//     language = null;
//     setState(() {
//       engine = selectedEngine;
//     });
//   }
//
//   List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
//       dynamic languages) {
//     var items = <DropdownMenuItem<String>>[];
//     for (dynamic type in languages) {
//       items.add(DropdownMenuItem(
//           value: type as String?, child: Text(type as String)));
//     }
//     return items;
//   }
//
//   void changedLanguageDropDownItem(String? selectedType) {
//     setState(() {
//       language = selectedType;
//       flutterTts.setLanguage(language!);
//       if (isAndroid) {
//         flutterTts
//             .isLanguageInstalled(language!)
//             .then((value) => isCurrentLanguageInstalled = (value as bool));
//       }
//     });
//   }
//
//   void _onChange(String text) {
//     setState(() {
//       _newVoiceText = text;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter TTS'),
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               _inputSection(),
//               _btnSection(),
//               _engineSection(),
//               _futureBuilder(),
//               _buildSliders(),
//               if (isAndroid) _getMaxSpeechInputLengthSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _engineSection() {
//     if (isAndroid) {
//       return FutureBuilder<dynamic>(
//           future: _getEngines(),
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             if (snapshot.hasData) {
//               return _enginesDropDownSection(snapshot.data);
//             } else if (snapshot.hasError) {
//               return Text('Error loading engines...');
//             } else
//               return Text('Loading engines...');
//           });
//     } else
//       return Container(width: 0, height: 0);
//   }
//
//   Widget _futureBuilder() => FutureBuilder<dynamic>(
//       future: _getLanguages(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.hasData) {
//           return _languageDropDownSection(snapshot.data);
//         } else if (snapshot.hasError) {
//           return Text('Error loading languages...');
//         } else
//           return Text('Loading Languages...');
//       });
//
//   Widget _inputSection() => Container(
//       alignment: Alignment.topCenter,
//       padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
//       child: TextField(
//         maxLines: 11,
//         minLines: 6,
//         onChanged: (String value) {
//           _onChange(value);
//         },
//       ));
//
//   Widget _btnSection() {
//     return Container(
//       padding: EdgeInsets.only(top: 50.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow,
//               'PLAY', _speak),
//           _buildButtonColumn(
//               Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
//           _buildButtonColumn(
//               Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
//         ],
//       ),
//     );
//   }
//
//   Widget _enginesDropDownSection(dynamic engines) => Container(
//     padding: EdgeInsets.only(top: 50.0),
//     child: DropdownButton(
//       value: engine,
//       items: getEnginesDropDownMenuItems(engines),
//       onChanged: changedEnginesDropDownItem,
//     ),
//   );
//
//   Widget _languageDropDownSection(dynamic languages) => Container(
//       padding: EdgeInsets.only(top: 10.0),
//       child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         DropdownButton(
//           value: language,
//           items: getLanguageDropDownMenuItems(languages),
//           onChanged: changedLanguageDropDownItem,
//         ),
//         Visibility(
//           visible: isAndroid,
//           child: Text("Is installed: $isCurrentLanguageInstalled"),
//         ),
//       ]));
//
//   Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
//       String label, Function func) {
//     return Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//               icon: Icon(icon),
//               color: color,
//               splashColor: splashColor,
//               onPressed: () => func()),
//           Container(
//               margin: const EdgeInsets.only(top: 8.0),
//               child: Text(label,
//                   style: TextStyle(
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w400,
//                       color: color)))
//         ]);
//   }
//
//   Widget _getMaxSpeechInputLengthSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           child: Text('Get max speech input length'),
//           onPressed: () async {
//             _inputLength = await flutterTts.getMaxSpeechInputLength;
//             setState(() {});
//           },
//         ),
//         Text("$_inputLength characters"),
//       ],
//     );
//   }
//
//   Widget _buildSliders() {
//     return Column(
//       children: [_volume(), _pitch(), _rate()],
//     );
//   }
//
//   Widget _volume() {
//     return Slider(
//         value: volume,
//         onChanged: (newVolume) {
//           setState(() => volume = newVolume);
//         },
//         min: 0.0,
//         max: 1.0,
//         divisions: 10,
//         label: "Volume: $volume");
//   }
//
//   Widget _pitch() {
//     return Slider(
//       value: pitch,
//       onChanged: (newPitch) {
//         setState(() => pitch = newPitch);
//       },
//       min: 0.5,
//       max: 2.0,
//       divisions: 15,
//       label: "Pitch: $pitch",
//       activeColor: Colors.red,
//     );
//   }
//
//   Widget _rate() {
//     return Slider(
//       value: rate,
//       onChanged: (newRate) {
//         setState(() => rate = newRate);
//       },
//       min: 0.0,
//       max: 1.0,
//       divisions: 10,
//       label: "Rate: $rate",
//       activeColor: Colors.green,
//     );
//   }
// }