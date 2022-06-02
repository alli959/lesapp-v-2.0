import 'PrefVoice.dart';

class Question {
  String questionText;
  bool questionAnswer;
  String file;
  String file2;
  PrefVoice prefVoice = PrefVoice.DORA;

  Question(this.questionText, this.questionAnswer, this.file,
      [this.file2, this.prefVoice]);
}
