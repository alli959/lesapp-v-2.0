class TotalPoints {
  //double score = 1;
  double _points = 0;
  double finalPoints = 0;

  int correct = 0;
  int trys = 0;

  String checkPoints(int correct, int trys) {
    if (trys == 0) {
      double score = calculatePoints(correct, 1) * 100.0;
      finalPoints = score;
      return score.toStringAsFixed(0);
    } else {
      double score = calculatePoints(correct, trys) * 100.0;
      finalPoints = score;
      return score.toStringAsFixed(0);
    }
  }

  double calculatePoints(int correct, int trys) {
    _points = correct / trys;
    finalPoints = _points;
    return _points;
  }
}
