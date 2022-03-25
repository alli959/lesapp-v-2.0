class Usr {
  final String uid;

  Usr({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String age;
  final String readingStage;
  final String lvlOneCapsScore;
  final String lvlOneScore;
  final String lvlOneVoiceScore;
  final String lvlThreeEasyScore;
  final String lvlThreeMediumScore;
  final String lvlThreeVoiceScore;
  final String lvlTwoEasyScore;
  final String lvlTwoMediumScore;
  final String lvlTwoVoiceScore;

  UserData(
      {this.uid,
      this.name,
      this.age,
      this.readingStage,
      this.lvlOneCapsScore,
      this.lvlOneScore,
      this.lvlOneVoiceScore,
      this.lvlThreeEasyScore,
      this.lvlThreeMediumScore,
      this.lvlThreeVoiceScore,
      this.lvlTwoEasyScore,
      this.lvlTwoMediumScore,
      this.lvlTwoVoiceScore});
}
