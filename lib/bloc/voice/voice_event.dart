part of 'voice_bloc.dart';

abstract class VoiceEvent extends Equatable {
  const VoiceEvent();

  @override
  List<Object> get props => [];
}

class VoiceInitializeEvent extends VoiceEvent {}

class VoiceStartedEvent extends VoiceEvent {}

class VoiceStoppedEvent extends VoiceEvent {}

class DisplayTextEvent extends VoiceEvent {}

class VoiceFailureEvent extends VoiceEvent {
  final String error;

  VoiceFailureEvent({@required this.error});

  @override
  List<Object> get props => [error];
}

class VoiceStatusEvent extends VoiceEvent {
  final String lastStatus;

  VoiceStatusEvent({@required this.lastStatus});

  @override
  List<Object> get props => [lastStatus];
}
