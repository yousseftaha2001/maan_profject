
// import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:test_speak/match_room/models/match_room_model.dart';
class MainPageState {
  late stt.SpeechToText speech;
  bool isListening = false;
  bool speaking = false;
  String text = 'Press the button and start speaking';
  double confidence = 1.0;
  FlutterTts flutterTts = FlutterTts();
  late MatchRoomModel matchRoomModel;
  int end = 0;
  String? currentid;
  String? currentCode;

  String? _newVoiceText;



  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;


  // SearchModel? searchModel;


  // TtsState state
  // TtsState ttsState = TtsState.stopped;
}
