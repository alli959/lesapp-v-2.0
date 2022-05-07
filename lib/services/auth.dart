import 'dart:async';

import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AuthService {
  // All of the authentication goes inside this class
  final _auth = Amplify.Auth;

  // create user object based on Firebase-user
  Usr _userFromCognitoUser(AuthUser user) {
    return user != null ? Usr(uid: user.userId) : null;
  }

  Future<bool> _IsLoggedIn() async {
    var authSession = await Amplify.Auth.fetchAuthSession();
    return authSession.isSignedIn;
  }

  // Everytime a Usr signs in or signs out we get a signal from the stream.
  // A null value if the user signs out but a Usr object if the user signs in.
  Stream<Usr> get user {
    print("usr get stuff called");
    return _auth.getCurrentUser().asStream().map(_userFromCognitoUser);
  }

  // GET CURRENT USER
  Future<AuthUser> getCurrentUser() async {
    return await _auth.getCurrentUser();
  }

  Future<String> getCurrentUserID() async {
    final user = await _auth.getCurrentUser();
    return user.userId;
  }

  // Future<String> getCurrentUserToken() async {
  //   return await _auth.currentUser.getIdToken();
  // }

  // // sign in with email and password
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print('Villan er: ' + e.toString());
  //     return null;
  //   }
  // }

  // SIGN IN w. email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      SignInResult res =
          await _auth.signIn(username: email, password: password);
      if (res.isSignedIn) {
        return _userFromCognitoUser(await getCurrentUser());
      }
    } catch (e) {
      print("what is going on...");
      print(e.toString());
      return null;
    }

    print("we should not be here");
    return null;
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
      SignUpResult result =
          await _auth.signUp(username: email, password: password);
      if (result.isSignUpComplete) {
        AuthUser user = await getCurrentUser();

        // create a new document for the user with the uid
        await DatabaseService(uid: user.userId).updateUserData(
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

        return _userFromCognitoUser(user);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    print("we should not be here");
    return null;
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
