//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: depend_on_referenced_packages

import 'package:audio_session/audio_session_web.dart';
// import 'package:audioplayers/web/audioplayers_web.dart';
// import 'package:connectivity_plus_web/connectivity_plus_web.dart';
import 'package:flutter_sound_web/flutter_sound_web.dart';
import 'package:speech_to_text/speech_to_text_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AudioSessionWeb.registerWith(registrar);
  // AudioplayersPlugin.registerWith(registrar);
  // ConnectivityPlusPlugin.registerWith(registrar);
  FlutterSoundPlugin.registerWith(registrar);
  SpeechToTextPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
