// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Lesaforrit/models/read.dart';
import 'package:Lesaforrit/models/usr.dart' as usr;
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';

import '../models/ModelProvider.dart';

// Klasi sem inniheldur allar aðferðir og eiginleika sem interacta við Firestore database.
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

// // Tilvísun í collection í database
//   final CollectionReference lesaCollection =
//       FirebaseFirestore.instance.collection('Notendur');

  final lesaCollection = Amplify.DataStore;
  //document er í auth // Þetta fall skrifar gildi í Firebase. Gildi í gæsalöppum verða að stemma

  Future updateUserData(
      String name,
      String age,
      String readingStage,
      String lvlOneCapsScore,
      String lvlOneScore,
      String lvlOneVoiceScore,
      String lvlThreeEasyScore,
      String lvlThreeMediumScore,
      String lvlThreeVoiceScore,
      String lvlTwoEasyScore,
      String lvlTwoMediumScore,
      String lvlTwoVoiceScore) async {
    UserData oldUserData = (await lesaCollection.query(UserData.classType,
        where: UserData.ID.eq(uid)))[0];

    UserData userData = oldUserData.copyWith(
        id: uid,
        name: name,
        age: age,
        readingStage: readingStage,
        lvlOneCapsScore: lvlOneCapsScore,
        lvlOneScore: lvlOneScore,
        lvlOneVoiceScore: lvlOneVoiceScore,
        lvlThreeMediumScore: lvlThreeMediumScore,
        lvlThreeVoiceScore: lvlThreeVoiceScore,
        lvlTwoEasyScore: lvlTwoEasyScore,
        lvlTwoMediumScore: lvlTwoMediumScore,
        lvlThreeEasyScore: lvlThreeEasyScore,
        lvlTwoVoiceScore: lvlTwoVoiceScore,
        prefVoice: PrefVoice.DORA,
        saveRecord: true,
        manualFix: false);
    return await lesaCollection.save(userData);
  }

  //document er í auth
  Future updateUserScore(String score, String typeof) async {
    UserData oldUserData = (await lesaCollection.query(UserData.classType,
        where: UserData.ID.eq(uid)))[0];

    UserData userData = oldUserData.copyWith(
        lvlOneCapsScore: typeof == "lvlOneCapsScore" ? score : null,
        lvlOneScore: typeof == "lvlOneScore" ? score : null,
        lvlOneVoiceScore: typeof == "lvlOneVoiceScore" ? score : null,
        lvlThreeEasyScore: typeof == "lvlThreeEasyScore" ? score : null,
        lvlThreeMediumScore: typeof == "lvlThreeMediumScore" ? score : null,
        lvlThreeVoiceScore: typeof == "lvlThreeVoiceScore" ? score : null,
        lvlTwoEasyScore: typeof == "lvlTwoEasyScore" ? score : null,
        lvlTwoMediumScore: typeof == "lvlTwoMediumScore" ? score : null,
        lvlTwoVoiceScore: typeof == "lvlTwoVoiceScore" ? score : null);
    return await lesaCollection.save(userData);
  }

  // read list from snapshot
  List<Read> _readListFromSnapshot(QuerySnapshot<UserData> snapshot) {
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
        readingStage: snapshot.item.toJson()['readingStage'],
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
  Stream<UserData> get userData {
    Stream<SubscriptionEvent<UserData>> stream =
        lesaCollection.observe(UserData.classType);
    return stream.map(_userDataFromSnapshot);
  }
}
