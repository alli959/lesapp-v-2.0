import 'dart:async';
import 'dart:convert';
import 'package:Lesaforrit/models/read.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;
import '../models/ModelProvider.dart';

// Klasi sem inniheldur allar aðferðir og eiginleika sem interacta við Firestore database.
class DatabaseService {
  String uid;
  final lesaCollection = Amplify.DataStore;
  DatabaseService({required this.uid});

  StreamSubscription hubSubscription = Amplify.Hub.listen(
      [HubChannel.DataStore] as HubChannel<dynamic, HubEvent<Object?>>,
      (hubEvent) async {});

  Future<void> updateUserData(UserData userData, UserScore userScore) async {
    print("we are at updateUserData");
    try {
      await lesaCollection.save(userData);
      await lesaCollection.save(userScore);
    } catch (err) {
      print("Error updating user data: $err");
    }
  }

  void setUid(String uid) {
    print("setUID: $uid");
    this.uid = uid;
  }

  //document er í auth
  Future<void> updateUserScore(UserScore userScore) async {
    print("IN update user score position");
    await lesaCollection.save(userScore);
  }

  // read list from snapshot
  List<Read> _readListFromSnapshot(QuerySnapshot<UserData> snapshot) {
    double lvlOneCapsScore;
    double lvlOneScore;
    double lvlOneVoiceScore;
    double lvlThreeMediumScore;
    double lvlThreeVoiceScore;
    double lvlThreeVoiceMediumScore;
    double lvlTwoEasyScore;
    double lvlTwoMediumScore;
    double lvlThreeEasyScore;
    double lvlTwoVoiceScore;
    double lvlTwoVoiceMediumScore;
    print("IN _readListFromSnapshot user score position");
    print(snapshot.items.last);
    // print("snapshot test")

    return snapshot.items.map((document) {
      print("snapshot test => ${document.UserScores}");
      double totalpoints = 0.0;
      var userID = document.id;
      var userScores = userScoreStream(
          userID,
          (QuerySnapshot<UserScore> usrscores) => {
                print("we are at query snapshot guy"),
                print("we are at query snapshot guy ${usrscores.items}"),
                lvlOneCapsScore = usrscores.items
                    .map((e) => e.lvlOneCapsScore)
                    .reduce(math.max),
                lvlOneScore =
                    usrscores.items.map((e) => e.lvlOneScore).reduce(math.max),
                lvlOneVoiceScore = usrscores.items
                    .map((e) => e.lvlOneVoiceScore)
                    .reduce(math.max),
                lvlThreeEasyScore = usrscores.items
                    .map((e) => e.lvlThreeEasyScore)
                    .reduce(math.max),
                lvlThreeMediumScore = usrscores.items
                    .map((e) => e.lvlThreeMediumScore)
                    .reduce(math.max),
                lvlThreeVoiceScore = usrscores.items
                    .map((e) => e.lvlThreeVoiceScore)
                    .reduce(math.max),
                lvlThreeVoiceMediumScore = usrscores.items
                    .map((e) => e.lvlThreeVoiceMediumScore)
                    .reduce(math.max),
                lvlTwoEasyScore = usrscores.items
                    .map((e) => e.lvlTwoEasyScore)
                    .reduce(math.max),
                lvlTwoMediumScore = usrscores.items
                    .map((e) => e.lvlTwoMediumScore)
                    .reduce(math.max),
                lvlTwoVoiceScore = usrscores.items
                    .map((e) => e.lvlTwoVoiceScore)
                    .reduce(math.max),
                lvlTwoVoiceMediumScore = usrscores.items
                    .map((e) => e.lvlTwoVoiceMediumScore)
                    .reduce(math.max),

                // get max points by user
                totalpoints = lvlOneCapsScore +
                    lvlOneScore +
                    lvlOneVoiceScore +
                    lvlThreeEasyScore +
                    lvlThreeMediumScore +
                    lvlThreeVoiceScore +
                    lvlThreeVoiceMediumScore +
                    lvlTwoEasyScore +
                    lvlTwoMediumScore +
                    lvlTwoVoiceScore +
                    lvlTwoVoiceMediumScore
              });
      // StreamProvider<UserScore>.value(
      //     value: state.users,

      return Read(
        name: document.toJson()['name'] ?? '',
        age: document.toJson()['age'] ?? '',
        school: document.toJson()['school'] ?? '',
        classname: document.toJson()['class'] ?? '',
        lvlOneCapsScore: lvlOneCapsScore ??
            // document.UserScores.map((e) => e.lvlOneCapsScore).reduce(math.max) ??
            0.0,
        lvlOneScore: lvlOneScore ??
            //document.UserScores.map((e) => e.lvlOneScore).reduce(math.max) ??
            0.0,
        lvlOneVoiceScore: lvlOneVoiceScore ??
            // document.UserScores.map((e) => e.lvlOneVoiceScore).reduce(math.max) ??
            0.0,
        lvlThreeEasyScore: lvlThreeEasyScore ??
            // document.UserScores.map((e) => e.lvlThreeEasyScore).reduce(math.max) ??
            0.0,
        lvlThreeMediumScore: lvlThreeMediumScore ??
            // document.UserScores.map((e) => e.lvlThreeMediumScore).reduce(math.max) ??
            0.0,
        lvlThreeVoiceScore: lvlThreeVoiceScore ??
            //  document.UserScores.map((e) => e.lvlThreeVoiceScore).reduce(math.max) ??
            0.0,
        lvlThreeVoiceMediumScore: lvlThreeVoiceMediumScore ??
            // document.UserScores.map((e) => e.lvlThreeVoiceMediumScore).reduce(math.max) ??
            0.0,
        lvlTwoEasyScore: lvlTwoEasyScore ??
            //  document.UserScores.map((e) => e.lvlTwoEasyScore).reduce(math.max) ??
            0.0,
        lvlTwoMediumScore: lvlTwoMediumScore ??
            //  document.UserScores.map((e) => e.lvlTwoMediumScore).reduce(math.max) ??
            0.0,
        lvlTwoVoiceScore: lvlTwoVoiceScore ??
            // document.UserScores.map((e) => e.lvlTwoVoiceScore).reduce(math.max) ??
            0.0,
        lvlTwoVoiceMediumScore: lvlTwoVoiceMediumScore ??
            // document.UserScores.map((e) => e.lvlTwoVoiceMediumScore).reduce(math.max) ??
            0.0,
        totalpoints: totalpoints ?? totalpoints,
      );
    }).toList();
  }

  // Get data from firestore to our app.
// Get stream from lesaCollection
  Stream<List<Read>> get users {
    return lesaCollection
        .observeQuery(UserData.classType)
        .map(_readListFromSnapshot);
  }

  UserData _userDataFromSnapshot(SubscriptionEvent snapshot) {
    return UserData(
        id: snapshot.item.getId(),
        name: snapshot.item.toJson()['name'],
        age: snapshot.item.toJson()['age'],
        school: snapshot.item.toJson()['school'],
        classname: snapshot.item.toJson()['class']);
  }

  UserScore _userScoreFromSnapshot(SubscriptionEvent snapshot) {
    var uuid = Uuid().v1();

    print("IN _userScoreFromSnapshot");
    return UserScore(
      id: uuid,
      userdataID: uid,
      lvlOneCapsScore: snapshot.item.toJson()['lvlOneCapsScore'],
      lvlOneScore: snapshot.item.toJson()['lvlOneScore'],
      lvlOneVoiceScore: snapshot.item.toJson()['lvlOneVoiceScore'],
      lvlThreeEasyScore: snapshot.item.toJson()['lvlThreeEasyScore'],
      lvlThreeMediumScore: snapshot.item.toJson()['lvlThreeMediumScore'],
      lvlThreeVoiceScore: snapshot.item.toJson()['lvlThreeVoiceScore'],
      lvlThreeVoiceMediumScore:
          snapshot.item.toJson()['lvlThreeVoiceMediumScore'],
      lvlTwoEasyScore: snapshot.item.toJson()['lvlTwoEasyScore'],
      lvlTwoMediumScore: snapshot.item.toJson()['lvlTwoMediumScore'],
      lvlTwoVoiceScore: snapshot.item.toJson()['lvlTwoVoiceScore'],
      lvlTwoVoiceMediumScore: snapshot.item.toJson()['lvlTwoVoiceMediumScore'],
    );
  }

  // Get user document
  Future<Stream<UserData>> get userData async {
    var user = await Amplify.Auth.getCurrentUser();
    return lesaCollection
        .observe(UserData.classType, where: UserData.ID.eq(user.userId))
        .map(_userDataFromSnapshot);
  }

  Future<Stream<UserScore>> get userScore async {
    var user = await Amplify.Auth.getCurrentUser();
    return lesaCollection
        .observe(UserScore.classType,
            where: UserScore.USERDATAID.eq(user.userId))
        .map(_userScoreFromSnapshot);
  }

  Stream<SubscriptionEvent<UserScore>> userScoreStream(
      String userID, callback) {
    return lesaCollection
        .observe(UserScore.classType, where: UserScore.USERDATAID.eq(userID))
        .map(callback);
  }

  Future<Map<String, dynamic>> GetSpecialData() async {
    print("we are at GetSpecialData");

    try {
      var user = await Amplify.Auth.getCurrentUser();
      print("userID IS ${user.userId}");
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(user.userId)));
      Map<String, dynamic> returner = {
        "prefVoice": oldUserData[0].prefVoice,
        "saveRecord": oldUserData[0].saveRecord,
        "manualFix": oldUserData[0].manualFix,
        "classname": oldUserData[0].classname,
        "school": oldUserData[0].school,
        "agreement": oldUserData[0].agreement,
        "name": oldUserData[0].name,
        "age": oldUserData[0].age,
      };
      String tempSchoolName = await getSchoolNameFromID(oldUserData[0].school);
      return returner;
    } catch (err) {
      print("there was an error getting user data ====> $err");
    }
  }

  Future<PrefVoice> getPreferedVoice() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      var prefVoice = oldUserData[0].prefVoice;
      print("prefVoice is $prefVoice");
      return prefVoice;
    } catch (err) {
      print("there was an error getting user data ====> $err");
    }
  }

  Future<bool> getIsSaveVoice() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      var isSaveVoice = oldUserData[0].saveRecord;
      print("prefVoice is $isSaveVoice");
      return isSaveVoice;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return false;
    }
  }

  Future<bool> getIsManualFix() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      var isManualFix = oldUserData[0].manualFix;
      print("manualFix is $isManualFix");
      return isManualFix;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return false;
    }
  }

  Future<bool> getAgreement() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      var isAgreement = oldUserData[0].agreement;
      print("agreement is $isAgreement");
      return isAgreement;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return false;
    }
  }

  Future<String> getClassname() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      var classname = oldUserData[0].classname;
      print("classname is $classname");
      return classname;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return "";
    }
  }

  Future<Schools> getSchoolID() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      var school = oldUserData[0].school;
      print("school is $school");
      return school;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return Schools.School1;
    }
  }

  Future<List<String>> getAllSchoolNames() async {
    try {
      var schoolJson = await rootBundle.loadString('assets/Schools.json');
      Map<String, dynamic> schoolMap = json.decode(schoolJson);
      List<String> schoolNames = [];
      schoolMap.forEach((key, value) {
        schoolNames.add(value);
      });
      return schoolNames;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return ["Utan Skóla"];
    }
  }

  Future<String> getSchoolName() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      var school = oldUserData[0].school;
      var schoolJson = await rootBundle.loadString('assets/Schools.json');
      Map<String, dynamic> schoolMap = json.decode(schoolJson);
      String schoolName = schoolMap[school.name];
      return schoolName;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return "Utan Skóla";
    }
  }

  Future<String> getSchoolNameFromID(Schools school) async {
    try {
      var schoolJson = await rootBundle.loadString('assets/Schools.json');
      Map<String, dynamic> schoolMap = json.decode(schoolJson);
      String schoolName = schoolMap[school.name];
      return schoolName;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return "Utan Skóla";
    }
  }

  Future<Schools> getSchoolIDFromName(String schoolName) async {
    try {
      var schoolJson =
          await rootBundle.loadString('assets/Schools-reverse.json');
      Map<String, dynamic> schoolMap = json.decode(schoolJson);
      print("schoolMap is $schoolMap");
      Schools schoolID = Schools.values.byName(schoolMap[schoolName]);
      return schoolID;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return Schools.School1;
    }
  }

  Future<void> saveSpecialData(UserData userData) async {
    print("we are at updateUserData");
    try {
      await lesaCollection.save(userData);
    } catch (err) {
      print("Error setting user data: $err");
    }
  }

  Future<double> getMaxSpecificValue(String label) async {
    try {
      List<UserScore> oldUserScore = (await lesaCollection.query(
          UserScore.classType,
          where: UserScore.USERDATAID.eq(this.uid),
          sortBy: [
            QuerySortBy(field: label, order: QuerySortOrder.descending)
          ]));

      double highScore = oldUserScore[0].toJson()[label];

      print("we are at the specific value place with highscore = $highScore");

      return highScore;
    } catch (err) {
      print("there was an error getting max value $err");
    }
  }

  Future<UserScore> getUserScores() async {
    double lvlOneCapsScore = await getMaxSpecificValue('lvlOneCapsScore');
    double lvlOneScore = await getMaxSpecificValue('lvlOneScore');
    double lvlOneVoiceScore = await getMaxSpecificValue('lvlOneVoiceScore');
    double lvlThreeEasyScore = await getMaxSpecificValue('lvlThreeEasyScore');
    double lvlThreeMediumScore =
        await getMaxSpecificValue('lvlThreeMediumScore');
    double lvlThreeVoiceScore = await getMaxSpecificValue('lvlThreeVoiceScore');
    double lvlThreeVoiceMediumScore =
        await getMaxSpecificValue('lvlThreeVoiceMediumScore');
    double lvlTwoEasyScore = await getMaxSpecificValue('lvlTwoEasyScore');
    double lvlTwoMediumScore = await getMaxSpecificValue('lvlTwoMediumScore');
    double lvlTwoVoiceScore = await getMaxSpecificValue('lvlTwoVoiceScore');
    double lvlTwoVoiceMediumScore =
        await getMaxSpecificValue('lvlTwoVoiceMediumScore');

    return UserScore(
      userdataID: uid,
      lvlOneCapsScore: lvlOneCapsScore,
      lvlOneScore: lvlOneScore,
      lvlOneVoiceScore: lvlOneVoiceScore,
      lvlThreeEasyScore: lvlThreeEasyScore,
      lvlThreeMediumScore: lvlThreeMediumScore,
      lvlThreeVoiceScore: lvlThreeVoiceScore,
      lvlThreeVoiceMediumScore: lvlThreeVoiceMediumScore,
      lvlTwoEasyScore: lvlTwoEasyScore,
      lvlTwoMediumScore: lvlTwoMediumScore,
      lvlTwoVoiceScore: lvlTwoVoiceScore,
      lvlTwoVoiceMediumScore: lvlTwoVoiceMediumScore,
    );
  }

  Future<UserScore> getUserScoresStream() async {
    double lvlOneCapsScore = await getMaxSpecificValue('lvlOneCapsScore');
    double lvlOneScore = await getMaxSpecificValue('lvlOneScore');
    double lvlOneVoiceScore = await getMaxSpecificValue('lvlOneVoiceScore');
    double lvlThreeEasyScore = await getMaxSpecificValue('lvlThreeEasyScore');
    double lvlThreeMediumScore =
        await getMaxSpecificValue('lvlThreeMediumScore');
    double lvlThreeVoiceScore = await getMaxSpecificValue('lvlThreeVoiceScore');
    double lvlThreeVoiceMediumScore =
        await getMaxSpecificValue('lvlThreeVoiceMediumScore');
    double lvlTwoEasyScore = await getMaxSpecificValue('lvlTwoEasyScore');
    double lvlTwoMediumScore = await getMaxSpecificValue('lvlTwoMediumScore');
    double lvlTwoVoiceScore = await getMaxSpecificValue('lvlTwoVoiceScore');
    double lvlTwoVoiceMediumScore =
        await getMaxSpecificValue('lvlTwoVoiceMediumScore');

    return UserScore(
      userdataID: uid,
      lvlOneCapsScore: lvlOneCapsScore,
      lvlOneScore: lvlOneScore,
      lvlOneVoiceScore: lvlOneVoiceScore,
      lvlThreeEasyScore: lvlThreeEasyScore,
      lvlThreeMediumScore: lvlThreeMediumScore,
      lvlThreeVoiceScore: lvlThreeVoiceScore,
      lvlThreeVoiceMediumScore: lvlThreeVoiceMediumScore,
      lvlTwoEasyScore: lvlTwoEasyScore,
      lvlTwoMediumScore: lvlTwoMediumScore,
      lvlTwoVoiceScore: lvlTwoVoiceScore,
      lvlTwoVoiceMediumScore: lvlTwoVoiceMediumScore,
    );
  }

  Future<UserData> getUserData() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      return oldUserData[0];
    } catch (err) {
      print("there was an error getting user data ====> $err");
    }
  }
}
