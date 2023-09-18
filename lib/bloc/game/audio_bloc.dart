import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/listeners/level_voice_listener.dart';
part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc() : super(InitState(gameType: VoiceGameType.letters));
/**The argument type 'Null' can't be assigned to the parameter type 'AudioState'.dartargument_type_not_assignable
Type: Null */
  @override
  Stream<AudioState> mapEventToState(AudioEvent event) async* {
    yield* _mapTypeOfGame(event as InitEvent);
  }

  Stream<AudioState> _mapTypeOfGame(InitEvent event) async* {
    yield InitState(gameType: event.gameType);
  }
}
