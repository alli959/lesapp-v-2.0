import 'dart:async';

import 'package:Lesaforrit/amplifyconfiguration.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import '../models/ModelProvider.dart';

class AuthService {
  Future init() async {
    try {
      // Add the following line to add Auth plugin to your app.
      AmplifyDataStore datastorePlugin =
          AmplifyDataStore(modelProvider: ModelProvider.instance);
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.addPlugin(AmplifyStorageS3());
      await Amplify.addPlugin(datastorePlugin);
      await Amplify.addPlugin(AmplifyAPI());

      await Amplify.configure(amplifyconfig);
      // call Amplify.configure to use the initialized categories in your app
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }

  // All of the authentication goes inside this class
  final _auth = Amplify.Auth;

  // create user object based on Firebase-user
  Usr _userFromCognitoUser(AuthUser user) {
    return user != null ? Usr(uid: user.userId) : null;
  }

  StreamSubscription hubSubscription =
      Amplify.Hub.listen([HubChannel.Auth], (hubEvent) async {
    switch (hubEvent.eventName) {
      case 'SIGNED_IN':
        print('USER IS SIGNED IN');
        break;
      case 'SIGNED_OUT':
        print('USER IS SIGNED OUT');
        try {
          await Amplify.DataStore.clear();
          print('DataStore is cleared.');
        } on DataStoreException catch (e) {
          print('Failed to clear DataStore: $e');
        }
        break;
      case 'SESSION_EXPIRED':
        print('SESSION HAS EXPIRED');
        break;
      case 'USER_DELETED':
        print('USER HAS BEEN DELETED');
        break;
      default:
        print("other hub activity is =>  ${hubEvent.eventName}");
    }
  });

  Future<bool> isLoggedIn() async {
    var authSession = await _auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true));
    return authSession.isSignedIn;
  }

  // Everytime a Usr signs in or signs out we get a signal from the stream.
  // A null value if the user signs out but a Usr object if the user signs in.
  Stream<Usr> get user {
    print("usr get stuff called");
    var authUser = getCurrentUser();
    if (authUser == null) {
      return null;
    }
    return authUser.asStream().map(_userFromCognitoUser);
  }

  // GET CURRENT USER
  Future<AuthUser> getCurrentUser() async {
    try {
      var currentUser = await _auth.getCurrentUser();

      return currentUser;
    } catch (err) {
      print("user is logged out");
      return null;
    }
  }

  Future<String> getCurrentUserID() async {
    final user = await getCurrentUser();
    if (user == null) {
      return null;
    }
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
      double lvlOneCapsScore,
      double lvlOneScore,
      double lvlOneVoiceScore,
      double lvlThreeEasyScore,
      double lvlThreeMediumScore,
      double lvlThreeVoiceScore,
      double lvlTwoEasyScore,
      double lvlTwoMediumScore,
      double lvlTwoVoiceScore) async {
    try {
      SignUpResult result =
          await _auth.signUp(username: email, password: password);
      if (result.isSignUpComplete) {
        print("Sign up is complete");
        print(
            " code delivery details => ${result.nextStep.codeDeliveryDetails}");
        await _auth.signIn(username: email, password: password);

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
  Future<void> logOut() async {
    try {
      return await _auth.signOut(options: SignOutOptions(globalSignOut: true));
    } on AmplifyException catch (e) {
      print("exception loggin out => ${e.message}");
    }
  }
}
