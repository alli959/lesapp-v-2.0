import 'package:flutter_cache_manager/file.dart';

class QuestionCache {
  String questionText;
  bool questionAnswer;
  File file;
  File? file2;

  QuestionCache(this.questionText, this.questionAnswer, this.file,
      [this.file2]);
}
