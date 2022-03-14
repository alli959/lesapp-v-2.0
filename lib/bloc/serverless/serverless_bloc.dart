import 'dart:convert';

import 'package:Lesaforrit/models/data.dart';
import 'package:Lesaforrit/models/question.dart';
import 'package:Lesaforrit/services/get_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'serverless_event.dart';
part 'serverless_state.dart';

class ServerlessBloc extends Bloc<ServerlessEvent, ServerlessState> {
  final GetData _data;
  final String _typeofgame;
  final String _typeofdifficulty;
  ServerlessBloc(GetData data, String typeofgame, String typeofdifficulty)
      : assert(data != null),
        _data = data,
        _typeofgame = typeofgame,
        _typeofdifficulty = typeofdifficulty,
        super(ServerlessInitial());

  @override
  Stream<ServerlessState> mapEventToState(ServerlessEvent event) async* {
    if (event is FetchEvent) {
      yield* _mapFetchData(event);
    }
  }

  Stream<ServerlessState> _mapFetchData(FetchEvent event) async* {
    // print("at fetchdata guy");
    yield ServerlessLoading();
    _data.setData(_typeofgame, _typeofdifficulty);
    List<Data> data;
    try {
      await Future.delayed((Duration(milliseconds: 5000)));
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
      print("data Text is ${textDecode}");
      Question question = Question(textDecode, true, value.Dora);
      questionBank.add(question);
    }

    yield ServerlessFetch(questionBank: questionBank);
  }
}
