import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/listeners/level_voice_listener.dart';
part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc() : super(null);

  @override
  Stream<AudioState> mapEventToState(AudioEvent event) async* {
    yield* _mapTypeOfGame(event);
  }

  Stream<AudioState> _mapTypeOfGame(InitEvent event) async* {
    yield InitState();
  }
}
