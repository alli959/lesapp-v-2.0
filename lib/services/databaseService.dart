import 'dart:async';
import 'dart:convert';
import 'package:Lesaforrit/models/read.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;
import '../models/ModelProvider.dart';

// Klasi sem inniheldur allar aðferðir og eiginleika sem interacta við Amplify database.
/// Service class for interacting with the Firestore database.
class DatabaseService {
  String uid;
  final lesaCollection = Amplify.DataStore;

  DatabaseService({required this.uid});

  StreamSubscription<DataStoreHubEvent> hubSubscription =
      Amplify.Hub.listen<DataStoreHubEventPayload, DataStoreHubEvent>(
          HubChannel.DataStore, (hubEvent) {
    // Handle the hub event here
  });

  /// Updates user data in the database.
  Future<void> updateUserData(UserData userData, UserScore? userScore) async {
    try {
      await lesaCollection.save(userData);
      if (userScore != null) {
        await lesaCollection.save(userScore);
      }
    } catch (err) {
      print("Error updating user data: $err");
    }
  }

  /// Sets the user ID.
  void setUid(String uid) {
    this.uid = uid;
  }

  /// Updates user score in the database.
  Future<void> updateUserScore(UserScore userScore) async {
    await lesaCollection.save(userScore);
  }

  // read list from snapshot
  List<Read> _readListFromSnapshot(QuerySnapshot<UserData> snapshot) {
    double? lvlOneCapsScore;
    double? lvlOneScore;
    double? lvlOneVoiceScore;
    double? lvlThreeMediumScore;
    double? lvlThreeVoiceScore;
    double? lvlThreeVoiceMediumScore;
    double? lvlTwoEasyScore;
    double? lvlTwoMediumScore;
    double? lvlThreeEasyScore;
    double? lvlTwoVoiceScore;
    double? lvlTwoVoiceMediumScore;
    print("IN _readListFromSnapshot user score position");
    print(snapshot.items.last);
    // print("snapshot test")

    return snapshot.items.map((document) {
      print("snapshot test => ${document.UserScores}");
      double? totalpoints = 0.0;
      var userID = document.id;
      var userScores = userScoreStream(
          userID,
          (QuerySnapshot<UserScore> usrscores) => {
                print("we are at query snapshot guy"),
                print("we are at query snapshot guy ${usrscores.items}"),
                lvlOneCapsScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlOneScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlOneScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlOneScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlOneVoiceScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlOneVoiceScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlThreeEasyScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlThreeEasyScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlThreeMediumScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlThreeMediumScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlThreeVoiceScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlThreeVoiceScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlThreeVoiceMediumScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlThreeVoiceMediumScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlTwoEasyScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlTwoEasyScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlTwoMediumScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlTwoMediumScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlTwoVoiceScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlTwoVoiceScore ?? 0.0)
                        .reduce(math.max),
                    0.0),
                lvlTwoVoiceMediumScore = math.max(
                    usrscores.items
                        .map((e) => e.lvlTwoVoiceMediumScore ?? 0.0)
                        .reduce(math.max),
                    0.0),

                // get max points by user
                totalpoints = lvlOneCapsScore! +
                    lvlOneScore! +
                    lvlOneVoiceScore! +
                    lvlThreeEasyScore! +
                    lvlThreeMediumScore! +
                    lvlThreeVoiceScore! +
                    lvlThreeVoiceMediumScore! +
                    lvlTwoEasyScore! +
                    lvlTwoMediumScore! +
                    lvlTwoVoiceScore! +
                    lvlTwoVoiceMediumScore!
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
        totalpoints: totalpoints ?? 0.0,
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
      name: (snapshot.item.toJson()['name'] as String?) ?? '',
      age: (snapshot.item.toJson()['age'] as String?) ?? '',
      school: (snapshot.item.toJson()['school'] as Schools?) ?? Schools.School1,
      classname: (snapshot.item.toJson()['class'] as String?) ?? '',
    );
  }

  UserScore _userScoreFromSnapshot(SubscriptionEvent snapshot) {
    var uuid = Uuid().v1();

    print("IN _userScoreFromSnapshot");
    return UserScore(
      id: uuid,
      userdataID: uid,
      lvlOneCapsScore:
          (snapshot.item.toJson()['lvlOneCapsScore'] as num?)?.toDouble(),
      lvlOneScore: (snapshot.item.toJson()['lvlOneScore'] as num?)?.toDouble(),
      lvlOneVoiceScore:
          (snapshot.item.toJson()['lvlOneVoiceScore'] as num?)?.toDouble(),
      lvlThreeEasyScore:
          (snapshot.item.toJson()['lvlThreeEasyScore'] as num?)?.toDouble(),
      lvlThreeMediumScore:
          (snapshot.item.toJson()['lvlThreeMediumScore'] as num?)?.toDouble(),
      lvlThreeVoiceScore:
          (snapshot.item.toJson()['lvlThreeVoiceScore'] as num?)?.toDouble(),
      lvlThreeVoiceMediumScore:
          (snapshot.item.toJson()['lvlThreeVoiceMediumScore'] as num?)
              ?.toDouble(),
      lvlTwoEasyScore:
          (snapshot.item.toJson()['lvlTwoEasyScore'] as num?)?.toDouble(),
      lvlTwoMediumScore:
          (snapshot.item.toJson()['lvlTwoMediumScore'] as num?)?.toDouble(),
      lvlTwoVoiceScore:
          (snapshot.item.toJson()['lvlTwoVoiceScore'] as num?)?.toDouble(),
      lvlTwoVoiceMediumScore:
          (snapshot.item.toJson()['lvlTwoVoiceMediumScore'] as num?)
              ?.toDouble(),
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
      AuthUser user = await Amplify.Auth.getCurrentUser();
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
      return returner;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return {
        "prefVoice": PrefVoice.DORA,
        "saveRecord": false,
        "manualFix": false,
        "classname": "",
        "school": Schools.School1,
        "agreement": false,
        "name": "",
        "age": "",
      };
    }
  }

  Future<PrefVoice> getPreferedVoice() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      var prefVoice = oldUserData[0].prefVoice;
      print("prefVoice is $prefVoice");
      return prefVoice ?? PrefVoice.DORA;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return PrefVoice.DORA;
    }
  }

  Future<bool> getIsSaveVoice() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      var isSaveVoice = oldUserData[0].saveRecord;
      print("prefVoice is $isSaveVoice");
      return isSaveVoice ?? false;
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
      return isManualFix ?? false;
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
      return isAgreement ?? false;
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return false;
    }
  }

  Future<String> getClassname() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      String? classname = oldUserData[0].classname;
      return classname ?? "";
    } catch (err) {
      print("there was an error getting user data ====> $err");
      return "";
    }
  }

  Future<Schools> getSchoolID() async {
    try {
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      Schools? school = oldUserData[0].school;
      print("school is $school");
      return school ?? Schools.School1;
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
      Schools? school = oldUserData[0].school;
      String schoolJson = await rootBundle.loadString('assets/Schools.json');
      Map<String, dynamic> schoolMap = json.decode(schoolJson);
      String schoolName = schoolMap[school?.name];
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

  /// Helper method to fetch max specific value from the database.
  Future<double> getMaxSpecificValue(String label) async {
    try {
      List<UserScore> oldUserScore = (await lesaCollection.query(
          UserScore.classType,
          where: UserScore.USERDATAID.eq(this.uid),
          sortBy: [
            QuerySortBy(field: label, order: QuerySortOrder.descending)
          ]));

      return oldUserScore[0].toJson()[label];
    } catch (err) {
      print("Error getting max value: $err");
      return 0.0; // Default value
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
      return UserData(
        id: "",
        name: "",
        age: "",
        school: Schools.School1,
        classname: "",
        prefVoice: PrefVoice.DORA,
        saveRecord: false,
        manualFix: false,
        agreement: false,
      );
    }
  }
}
