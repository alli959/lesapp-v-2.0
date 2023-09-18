import 'dart:convert';

import 'package:Lesaforrit/models/data.dart';
import 'package:Lesaforrit/models/question.dart';
import 'package:Lesaforrit/services/get_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/PrefVoice.dart';

part 'serverless_event.dart';
part 'serverless_state.dart';

class ServerlessBloc extends Bloc<ServerlessEvent, ServerlessState> {
  final GetData _data;
  final String _typeofgame;
  String _typeofdifficulty;
  ServerlessBloc(GetData data, String typeofgame, String typeofdifficulty)
      : _data = data,
        _typeofgame = typeofgame,
        _typeofdifficulty = typeofdifficulty,
        super(ServerlessInitial());

  @override
  Stream<ServerlessState> mapEventToState(ServerlessEvent event) async* {
    if (event is FetchEvent) {
      yield* _mapFetchData(event);
    }
    if (event is CheckAnswerEvent) {
      yield* _checkAnswer(event);
    }
    if (event is PlayGameEvent) {
      yield* _playGame(event);
    }
  }

  Stream<ServerlessState> _mapFetchData(FetchEvent event) async* {
    print("at fetchdata guy");
    yield ServerlessLoading();
    print("ERR EVENT DIFFICULTY IS NOT NULL");
    await event.difficulty(
        (String difficulty) => {this._typeofdifficulty = difficulty});
    yield DifficultySet();
    yield ServerlessLoading();
    print(
        "bloc type of game and difficulty is $_typeofgame, $_typeofdifficulty");
    _data.setData(_typeofgame, _typeofdifficulty);
    List<Data> data;
    try {
      data = await _data.getData();
    } catch (err) {
      print("there was an error $err");
      throw err;
    }
    List<Question> questionBank = [];
    for (var i = 0; i < data.length; i++) {
      Data value = data[i];
      List<int> textEncode = utf8.encode(value.Text);
      String textDecode = utf8.decode(textEncode);
      var voiceType = await event.prefvoice;
      print("voiceType is =============> $voiceType");
      Question question = Question(textDecode, true, value.Dora,
          file2: value.Karl, prefVoice: voiceType);
      questionBank.add(question);
    }
    yield ServerlessFetch(questionBank: questionBank);
  }

  Stream<ServerlessState> _playGame(PlayGameEvent event) async* {
    yield PlayGameState();
  }

  Stream<ServerlessState> _checkAnswer(CheckAnswerEvent event) async* {
    bool wasCorrect = false;
    print("userAnswer = ${event.userAnswer}");
    print("correctanswer = ${event.correctAnswer}");
    if (event.userAnswer == true) {
      if (event.userAnswer == event.correctAnswer) {
        wasCorrect = true;
        yield CheckAnswerState(
            upperImageCorrect: true,
            lowerImageCorrect: false,
            upperImageIncorrect: false,
            lowerImageIncorrect: false);

        await Future.delayed(Duration(milliseconds: 1000));
      } else {
        wasCorrect = false;
        yield CheckAnswerState(
            upperImageCorrect: false,
            lowerImageCorrect: false,
            upperImageIncorrect: true,
            lowerImageIncorrect: false);

        await Future.delayed(Duration(milliseconds: 1000));
      }
    } else {
      if (event.userAnswer == event.correctAnswer) {
        wasCorrect = true;
        yield CheckAnswerState(
            upperImageCorrect: false,
            lowerImageCorrect: true,
            upperImageIncorrect: false,
            lowerImageIncorrect: false);

        await Future.delayed(Duration(milliseconds: 1000));
      } else {
        wasCorrect = false;

        yield CheckAnswerState(
            upperImageCorrect: false,
            lowerImageCorrect: false,
            upperImageIncorrect: false,
            lowerImageIncorrect: true);
        await Future.delayed(Duration(milliseconds: 1000));
      }
    }
    print(
        "IS THIS THILL HERE????????????????????????????? \n $_typeofgame, $_typeofdifficulty");
    yield NewQuestionState(wasCorrect: wasCorrect);
  }
}
