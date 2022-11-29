import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecorderState {
  //   stt.SpeechToText? speech=stt.SpeechToText();
  // bool isListening = false;
  // bool va = false;
  // RxString text = 'Press the button and start speaking'.obs;
  // FlutterTts flutterTts = FlutterTts();
  // RxDouble confidence = 1.0.obs;
  // final Map<String, HighlightedWord> highlights = {
  //   'flutter': HighlightedWord(
  //     onTap: () => print('oo'),
  //     textStyle: const TextStyle(
  //       color: Colors.blue,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
    
  // };
    late stt.SpeechToText speech;
  bool isListening = false;
  String text = 'Press the button and start speaking';
  double confidence = 1.0;



  RecorderState(){
    // speech=stt.SpeechToText();
  }
}