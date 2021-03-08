import 'package:Lesaforrit/models/user.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // All of the authentication goes inside this class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on Firebase-user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Everytime a User signs in or signs out we get a signal from the stream.
  // A null value if the user signs out but a User object if the user signs in.
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _auth.currentUser;
  }

  // sign in with email and password
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Villan er: ' + e.toString());
      return null;
    }
  }

  // SIGN IN w. email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // REGISTER w. email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String name,
      String score,
      String scoreCaps,
      String age,
      String readingStage,
      String scoreTwo,
      String scoreTwoLong,
      String ScoreThree,
      String ScoreThreeLong) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
          name,
          score,
          scoreCaps,
          age,
          readingStage,
          scoreTwo,
          scoreTwoLong,
          ScoreThree,
          ScoreThreeLong);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signout
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Villa í logout' + e.toString());
      return null;
    }
  }
}
