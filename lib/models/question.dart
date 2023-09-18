import 'PrefVoice.dart';

class Question {
  String questionText;
  bool questionAnswer;
  String file;
  String? file2;
  PrefVoice prefVoice;

  Question(
    this.questionText,
    this.questionAnswer,
    this.file, {
    this.file2,
    this.prefVoice = PrefVoice.DORA, // Set the default value here
  });

  String getQuestionText() => questionText;

  bool getQuestionAnswer() => questionAnswer;

  String getFile() => file;

  String? getFile2() => file2;

  PrefVoice getPrefVoice() => prefVoice;

  void setPrefVoice(PrefVoice prefVoice) {
    this.prefVoice = prefVoice;
  }

  void setQuestionText(String questionText) {
    this.questionText = questionText;
  }

  void setQuestionAnswer(bool questionAnswer) {
    this.questionAnswer = questionAnswer;
  }

  void setFile(String file) {
    this.file = file;
  }

  void setFile2(String file2) {
    this.file2 = file2;
  }

  @override
  String toString() {
    return 'Question{questionText: $questionText, questionAnswer: $questionAnswer, file: $file, file2: $file2, prefVoice: $prefVoice}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question &&
          runtimeType == other.runtimeType &&
          questionText == other.questionText &&
          questionAnswer == other.questionAnswer &&
          file == other.file &&
          file2 == other.file2 &&
          prefVoice == other.prefVoice;
}
