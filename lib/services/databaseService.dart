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
      String score,
      String scoreCaps,
      String age,
      String readingStage,
      String scoreTwo,
      String scoreTwoLong,
      String scoreThree,
      String scoreThreeLong) async {
    return await lesaCollection.doc(uid).set({
      'age': age,
      'name': name,
      'readingStage': readingStage,
      'score': score,
      'scoreCaps': scoreCaps,
      'scoreTwo': scoreTwo,
      'scoreTwoLong': scoreTwoLong,
      'scoreThree': scoreThree,
      'scoreThreeLong': scoreThreeLong,
    });
  }

  //document er í auth
  Future updateUserScore(String score) async {
    return await lesaCollection.doc(uid).set({
      'score': score,
    });
  }

  // read list from snapshot
  List<Read> _readListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      double totalpoints = double.parse(document['score']) +
          double.parse(document['scoreTwo']) +
          double.parse(document['scoreThree']) +
          double.parse(document['scoreCaps']) +
          double.parse(document['scoreTwoLong']) +
          double.parse(document['scoreThreeLong']);
      return Read(
        name: document['name'] ?? '',
        score: document['score'] ?? '',
        scoreCaps: document['scoreCaps'] ?? '',
        scoreTwo: document['scoreTwo'] ?? '',
        scoreTwoLong: document['scoreTwoLong'] ?? '',
        scoreThree: document['scoreThree'] ?? '',
        scoreThreeLong: document['scoreThreeLong'] ?? '',
        age: document['age'] ?? '',
        readingStage: document['readingStage'] ?? '',
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
        score: snapshot['score'],
        scoreCaps: snapshot['scoreCaps'],
        scoreTwo: snapshot['scoreTwo'],
        scoreTwoLong: snapshot['scoreTwoLong'],
        scoreThree: snapshot['scoreThree'],
        scoreThreeLong: snapshot['scoreThreeLong']);
  }

  // Get user document
  Stream<UserData> get userData {
    return lesaCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
