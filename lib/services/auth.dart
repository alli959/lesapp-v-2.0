import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // All of the authentication goes inside this class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on Firebase-user
  Usr _userFromFirebaseUser(User user) {
    return user != null ? Usr(uid: user.uid) : null;
  }

  // Everytime a Usr signs in or signs out we get a signal from the stream.
  // A null value if the user signs out but a Usr object if the user signs in.
  Stream<Usr> get user {
    print("usr get stuff called");
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _auth.currentUser;
  }

  Future getCurrentUserID() async {
    return _auth.currentUser.uid;
  }

  // sign in with email and password
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Villan er: ' + e.toString());
      return null;
    }
  }

  // SIGN IN w. email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("what is going on...");
      print(e.toString());
      return null;
    }
  }

  // REGISTER w. email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
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
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
        name,
        age,
        readingStage,
        lvlOneCapsScore,
        lvlOneScore,
        lvlOneVoiceScore,
        lvlThreeEasyScore,
        lvlThreeMediumScore,
        lvlThreeVoiceScore,
        lvlTwoEasyScore,
        lvlTwoMediumScore,
        lvlTwoVoiceScore,
      );

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
