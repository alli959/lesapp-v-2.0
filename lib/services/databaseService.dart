// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:Lesaforrit/models/read.dart';
import 'package:Lesaforrit/models/usr.dart' as usr;
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:uuid/uuid.dart';

import '../models/ModelProvider.dart';

// Klasi sem inniheldur allar aðferðir og eiginleika sem interacta við Firestore database.
class DatabaseService {
  String uid;
  DatabaseService({this.uid});

// // Tilvísun í collection í database
//   final CollectionReference lesaCollection =
//       FirebaseFirestore.instance.collection('Notendur');

  final lesaCollection = Amplify.DataStore;

  StreamSubscription hubSubscription =
      Amplify.Hub.listen([HubChannel.DataStore], (hubEvent) async {
    print("EVENT NAME IS ===============> ${hubEvent.eventName}");
    print("EVENT PAYLOAD IS ===============> ${hubEvent.payload}");
  });

  Future updateUserData(
      String name,
      String age,
      String readingStage,
      double lvlOneCapsScore,
      double lvlOneScore,
      double lvlOneVoiceScore,
      double lvlThreeEasyScore,
      double lvlThreeMediumScore,
      double lvlThreeVoiceScore,
      double lvlTwoEasyScore,
      double lvlTwoMediumScore,
      double lvlTwoVoiceScore) async {
    print("we are at updateUserData");

    try {
      // List<UserData> oldUserData = (await lesaCollection
      //     .query(UserData.classType, where: UserData.UID.eq(this.uid)));
      // print("oldUserData is $oldUserData");
      var uuid = Uuid().v1();
      // if (oldUserData.length == 0) {
      UserData userData = UserData(
          id: this.uid,
          name: name,
          age: age,
          readingStage: readingStage,
          prefVoice: PrefVoice.DORA,
          saveRecord: true,
          manualFix: false);

      UserScore userScore = UserScore(
        id: uuid,
        userdataID: uid,
        lvlOneCapsScore: lvlOneCapsScore,
        lvlOneScore: lvlOneScore,
        lvlOneVoiceScore: lvlOneVoiceScore,
        lvlThreeMediumScore: lvlThreeMediumScore,
        lvlThreeVoiceScore: lvlThreeVoiceScore,
        lvlTwoEasyScore: lvlTwoEasyScore,
        lvlTwoMediumScore: lvlTwoMediumScore,
        lvlThreeEasyScore: lvlThreeEasyScore,
        lvlTwoVoiceScore: lvlTwoVoiceScore,
      );
      await lesaCollection.save(userData);
      return await lesaCollection.save(userScore);
      // }

      // UserData userData = oldUserData[0].copyWith(
      //     Uid: uid,
      //     name: name,
      //     age: age,
      //     readingStage: readingStage,
      //     lvlOneCapsScore: lvlOneCapsScore,
      //     lvlOneScore: lvlOneScore,
      //     lvlOneVoiceScore: lvlOneVoiceScore,
      //     lvlThreeMediumScore: lvlThreeMediumScore,
      //     lvlThreeVoiceScore: lvlThreeVoiceScore,
      //     lvlTwoEasyScore: lvlTwoEasyScore,
      //     lvlTwoMediumScore: lvlTwoMediumScore,
      //     lvlThreeEasyScore: lvlThreeEasyScore,
      //     lvlTwoVoiceScore: lvlTwoVoiceScore);
      // return await lesaCollection.save(userData);
    } catch (err) {
      print("there was an error updating user data ====> $err");
    }
  }

  void setUid(String uid) {
    print("setUID going on ====> $uid");
    this.uid = uid;
  }

  //document er í auth
  Future updateUserScore(double score, String typeof) async {
    print("IN update user score position");

    List<UserScore> oldUserDataTemp = (await lesaCollection
        .query(UserScore.classType, where: UserScore.USERDATAID.eq(uid)));

    print("length of old user data temp = ${oldUserDataTemp.length}");

    UserScore oldUserData = oldUserDataTemp[0];
    var uuid = Uuid().v1();
    UserScore userScore = oldUserData.copyWith(
        id: uuid,
        lvlOneCapsScore: typeof == "lvlOneCapsScore" ? score : null,
        lvlOneScore: typeof == "lvlOneScore" ? score : null,
        lvlOneVoiceScore: typeof == "lvlOneVoiceScore" ? score : null,
        lvlThreeEasyScore: typeof == "lvlThreeEasyScore" ? score : null,
        lvlThreeMediumScore: typeof == "lvlThreeMediumScore" ? score : null,
        lvlThreeVoiceScore: typeof == "lvlThreeVoiceScore" ? score : null,
        lvlTwoEasyScore: typeof == "lvlTwoEasyScore" ? score : null,
        lvlTwoMediumScore: typeof == "lvlTwoMediumScore" ? score : null,
        lvlTwoVoiceScore: typeof == "lvlTwoVoiceScore" ? score : null);
    return await lesaCollection.save(userScore);
  }

  // read list from snapshot
  List<Read> _readListFromSnapshot(QuerySnapshot<UserData> snapshot) {
    print("IN _readListFromSnapshot user score position");

    return snapshot.items.map((document) {
      double totalpoints = double.parse(document.toJson()['lvlOneCapsScore']) +
          double.parse(document.toJson()['lvlOneScore']) +
          double.parse(document.toJson()['lvlOneVoiceScore']) +
          double.parse(document.toJson()['lvlThreeEasyScore']) +
          double.parse(document.toJson()['lvlThreeMediumScore']) +
          double.parse(document.toJson()['lvlThreeVoiceScore']) +
          double.parse(document.toJson()['lvlTwoEasyScore']) +
          double.parse(document.toJson()['lvlTwoMediumScore']) +
          double.parse(document.toJson()['lvlTwoVoiceScore']);

      return Read(
        name: document.toJson()['name'] ?? '',
        age: document.toJson()['age'] ?? '',
        readingStage: document.toJson()['readingStage'] ?? '',
        lvlOneCapsScore: document.toJson()['lvlOneCapsScore'] ?? '',
        lvlOneScore: document.toJson()['lvlOneScore'] ?? '',
        lvlOneVoiceScore: document.toJson()['lvlOneVoiceScore'] ?? '',
        lvlThreeEasyScore: document.toJson()['lvlThreeEasyScore'] ?? '',
        lvlThreeMediumScore: document.toJson()['lvlThreeMediumScore'] ?? '',
        lvlThreeVoiceScore: document.toJson()['lvlThreeVoiceScore'] ?? '',
        lvlTwoEasyScore: document.toJson()['lvlTwoEasyScore'] ?? '',
        lvlTwoMediumScore: document.toJson()['lvlTwoMediumScore'] ?? '',
        lvlTwoVoiceScore: document.toJson()['lvlTwoVoiceScore'] ?? '',
        totalpoints: totalpoints,
      );
    }).toList();
  }

  // Get data from firestore to our app.
// Get stream from lesaCollection
  Stream<List<Read>> get users {
    Stream<QuerySnapshot<UserData>> stream =
        lesaCollection.observeQuery(UserData.classType);
    return stream.map(_readListFromSnapshot);
  }

  UserData _userDataFromSnapshot(SubscriptionEvent snapshot) {
    return UserData(
        id: uid,
        name: snapshot.item.toJson()['name'],
        age: snapshot.item.toJson()['age'],
        readingStage: snapshot.item.toJson()['readingStage']);
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
        lvlTwoEasyScore: snapshot.item.toJson()['lvlTwoEasyScore'],
        lvlTwoMediumScore: snapshot.item.toJson()['lvlTwoMediumScore'],
        lvlTwoVoiceScore: snapshot.item.toJson()['lvlTwoVoiceScore']);
  }

  // Get user document
  Future<Stream<UserData>> get userData async {
    var user = await Amplify.Auth.getCurrentUser();
    Stream<SubscriptionEvent<UserData>> stream = lesaCollection
        .observe(UserData.classType, where: UserData.ID.eq(user.userId));
    return stream.map(_userDataFromSnapshot);
  }

  Future<Stream<UserScore>> get userScore async {
    var user = await Amplify.Auth.getCurrentUser();

    Stream<SubscriptionEvent<UserScore>> stream = lesaCollection
        .observe(UserScore.classType, where: UserScore.ID.eq(user.userId));
    return stream.map(_userScoreFromSnapshot);
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
        "manualFix": oldUserData[0].manualFix
      };
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
    }
  }

  Future<void> saveSpecialData(
      PrefVoice prefVoice, bool saveRecord, bool manualFix) async {
    print("we are at updateUserData");

    try {
      print("userID IS ${this.uid}");
      List<UserData> oldUserData = (await lesaCollection
          .query(UserData.classType, where: UserData.ID.eq(this.uid)));
      UserData userData = oldUserData[0].copyWith(
          id: this.uid,
          prefVoice: prefVoice,
          saveRecord: saveRecord,
          manualFix: manualFix);

      return await lesaCollection.save(userData);
    } catch (err) {
      print("there was an error getting user data ====> $err");
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
}
