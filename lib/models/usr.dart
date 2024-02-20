class Usr {
  final String? uid;

  Usr({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String age;
  final String school;
  final String classname;
  final String lvlOneCapsScore;
  final String lvlOneScore;
  final String lvlOneVoiceScore;
  final String lvlThreeEasyScore;
  final String lvlThreeMediumScore;
  final String lvlThreeVoiceScore;
  final String lvlThreeVoiceMediumScore;
  final String lvlTwoEasyScore;
  final String lvlTwoMediumScore;
  final String lvlTwoVoiceScore;
  final String lvlTwoVoiceMediumScore;

  UserData(
      {required this.uid,
      required this.name,
      required this.age,
      required this.school,
      required this.classname,
      required this.lvlOneCapsScore,
      required this.lvlOneScore,
      required this.lvlOneVoiceScore,
      required this.lvlThreeEasyScore,
      required this.lvlThreeMediumScore,
      required this.lvlThreeVoiceScore,
      required this.lvlThreeVoiceMediumScore,
      required this.lvlTwoEasyScore,
      required this.lvlTwoMediumScore,
      required this.lvlTwoVoiceScore,
      required this.lvlTwoVoiceMediumScore});
}
