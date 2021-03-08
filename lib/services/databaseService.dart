import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Lesaforrit/models/read.dart';
import 'package:Lesaforrit/models/user.dart';

// Klasi sem inniheldur allar aðferðir og eiginleika sem interacta við Firestore database.
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

// Tilvísun í collection í database
  final CollectionReference lesaCollection =
      Firestore.instance.collection('Notendur');

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
    return await lesaCollection.document(uid).setData({
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
    return await lesaCollection.document(uid).setData({
      'score': score,
    });
  }

  // read list from snapshot
  List<Read> _readListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      double totalpoints = double.parse(doc.data['score']) +
          double.parse(doc.data['scoreTwo']) +
          double.parse(doc.data['scoreThree']) +
          double.parse(doc.data['scoreCaps']) +
          double.parse(doc.data['scoreTwoLong']) +
          double.parse(doc.data['scoreThreeLong']);
      return Read(
        name: doc.data['name'] ?? '',
        score: doc.data['score'] ?? '',
        scoreCaps: doc.data['scoreCaps'] ?? '',
        scoreTwo: doc.data['scoreTwo'] ?? '',
        scoreTwoLong: doc.data['scoreTwoLong'] ?? '',
        scoreThree: doc.data['scoreThree'] ?? '',
        scoreThreeLong: doc.data['scoreThreeLong'] ?? '',
        age: doc.data['age'] ?? '',
        readingStage: doc.data['readingStage'] ?? '',
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
        name: snapshot.data['name'],
        age: snapshot.data['age'],
        readingStage: snapshot.data['readingStage'],
        score: snapshot.data['score'],
        scoreCaps: snapshot.data['scoreCaps'],
        scoreTwo: snapshot.data['scoreTwo'],
        scoreTwoLong: snapshot.data['scoreTwoLong'],
        scoreThree: snapshot.data['scoreThree'],
        scoreThreeLong: snapshot.data['scoreThreeLong']);
  }

  // Get user document
  Stream<UserData> get userData {
    return lesaCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
