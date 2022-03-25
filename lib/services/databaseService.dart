import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Lesaforrit/models/read.dart';
import 'package:Lesaforrit/models/usr.dart';

// Klasi sem inniheldur allar aðferðir og eiginleika sem interacta við Firestore database.
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

// Tilvísun í collection í database
  final CollectionReference lesaCollection =
      FirebaseFirestore.instance.collection('Notendur');

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
    return await lesaCollection.doc(uid).set({
      'name': name,
      'age': age,
      'readingStage': readingStage,
      'lvlOneCapsScore': lvlOneCapsScore,
      'lvlOneScore': lvlOneScore,
      'lvlOneVoiceScore': lvlOneVoiceScore,
      'lvlThreeEasyScore': lvlThreeEasyScore,
      'lvlThreeMediumScore': lvlThreeMediumScore,
      'lvlThreeVoiceScore': lvlThreeVoiceScore,
      'lvlTwoEasyScore': lvlTwoEasyScore,
      'lvlTwoMediumScore': lvlTwoMediumScore,
      'lvlTwoVoiceScore': lvlTwoVoiceScore
    });
  }

  //document er í auth
  Future updateUserScore(String score, String typeof) async {
    return await lesaCollection.doc(uid).update({
      typeof: score,
    });
  }

  // read list from snapshot
  List<Read> _readListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      double totalpoints = double.parse(document['lvlOneCapsScore']) +
          double.parse(document['lvlOneScore']) +
          double.parse(document['lvlOneVoiceScore']) +
          double.parse(document['lvlThreeEasyScore']) +
          double.parse(document['lvlThreeMediumScore']) +
          double.parse(document['lvlThreeVoiceScore']) +
          double.parse(document['lvlTwoEasyScore']) +
          double.parse(document['lvlTwoMediumScore']) +
          double.parse(document['lvlTwoVoiceScore']);

      return Read(
        name: document['name'] ?? '',
        age: document['age'] ?? '',
        readingStage: document['readingStage'] ?? '',
        lvlOneCapsScore: document['lvlOneCapsScore'] ?? '',
        lvlOneScore: document['lvlOneScore'] ?? '',
        lvlOneVoiceScore: document['lvlOneVoiceScore'] ?? '',
        lvlThreeEasyScore: document['lvlThreeEasyScore'] ?? '',
        lvlThreeMediumScore: document['lvlThreeMediumScore'] ?? '',
        lvlThreeVoiceScore: document['lvlThreeVoiceScore'] ?? '',
        lvlTwoEasyScore: document['lvlTwoEasyScore'] ?? '',
        lvlTwoMediumScore: document['lvlTwoMediumScore'] ?? '',
        lvlTwoVoiceScore: document['lvlTwoVoiceScore'] ?? '',
        totalpoints: totalpoints,
      );
    }).toList();
  }

  // Get data from firestore to our app.
// Get stream from lesaCollection
  Stream<List<Read>> get users {
    return lesaCollection.snapshots().map(_readListFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        age: snapshot['age'],
        readingStage: snapshot['readingStage'],
        lvlOneCapsScore: snapshot['lvlOneCapsScore'],
        lvlOneScore: snapshot['lvlOneScore'],
        lvlOneVoiceScore: snapshot['lvlOneVoiceScore'],
        lvlThreeEasyScore: snapshot['lvlThreeEasyScore'],
        lvlThreeMediumScore: snapshot['lvlThreeMediumScore'],
        lvlThreeVoiceScore: snapshot['lvlThreeVoiceScore'],
        lvlTwoEasyScore: snapshot['lvlTwoEasyScore'],
        lvlTwoMediumScore: snapshot['lvlTwoMediumScore'],
        lvlTwoVoiceScore: snapshot['lvlTwoVoiceScore']);
  }

  // Get user document
  Stream<UserData> get userData {
    return lesaCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
