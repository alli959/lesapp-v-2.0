import 'dart:async';

import 'package:Lesaforrit/amplifyconfiguration.dart';
import 'package:Lesaforrit/models/usr.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:Lesaforrit/models/UserData.dart' as UserDataType;

import '../models/ModelProvider.dart';

class AuthService {
  // All of the authentication goes inside this class
  final _auth = Amplify.Auth;

  StreamSubscription hubSubscription = _configureHubSubscription();

  Future<void> init() async {
    try {
      await _configureAmplify();
    } catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    var authSession = await _auth.fetchAuthSession(
        // ignore: deprecated_member_use
        options: CognitoSessionOptions(getAWSCredentials: true));
    return authSession.isSignedIn;
  }

  // Everytime a Usr signs in or signs out we get a signal from the stream.
  // A null value if the user signs out but a Usr object if the user signs in.
  Stream<Usr?> get user {
    return getCurrentUser().asStream().map(_userFromCognitoUser);
  }

  // GET CURRENT USER
  Future<AuthUser?> getCurrentUser() async {
    try {
      return await _auth.getCurrentUser();
    } on SignedOutException catch (e) {
      print("No user is currently signed in: ${e.message}");
      // Handle the exception here - for example, redirect to a login screen
      return null;
    } catch (e) {
      print("Error getting current user: $e");
      return null;
    }
  }

  Future<String?> getCurrentUserID() async {
    if (await isLoggedIn()) {
      final user = await getCurrentUser();
      return user?.userId;
    } else {
      // Handle the scenario when no user is logged in
      print("No user is currently signed in");
      return null;
    }
  }

  Future<bool> isAmplifyConfigured() async {
    try {
      await Amplify.Auth.fetchAuthSession();
      return true;
    } on AmplifyAlreadyConfiguredException {
      return true;
    } catch (e) {
      return false;
    }
  }

  // SIGN IN w. email and password
  Future<Usr?> signInWithEmailAndPassword(String email, String password) async {
    try {
      SignInResult res =
          await _auth.signIn(username: email, password: password);
      if (res.isSignedIn) {
        return _userFromCognitoUser(await getCurrentUser());
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  // REGISTER w. email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String name,
      String age,
      String school,
      String classname,
      bool agreement,
      double lvlOneCapsScore,
      double lvlOneScore,
      double lvlOneVoiceScore,
      double lvlThreeEasyScore,
      double lvlThreeMediumScore,
      double lvlThreeVoiceScore,
      double lvlThreeVoiceMediumScore,
      double lvlTwoEasyScore,
      double lvlTwoMediumScore,
      double lvlTwoVoiceScore,
      double lvlTwoVoiceMediumScore) async {
    //printing all parameters with parameter name and value and new line between each
    print(
        "email: $email \n password: $password \n name: $name \n age: $age \n school: $school \n classname: $classname \n agreement: $agreement \n lvlOneCapsScore: $lvlOneCapsScore \n lvlOneScore: $lvlOneScore \n lvlOneVoiceScore: $lvlOneVoiceScore \n lvlThreeEasyScore: $lvlThreeEasyScore \n lvlThreeMediumScore: $lvlThreeMediumScore \n lvlThreeVoiceScore: $lvlThreeVoiceScore \n lvlThreeVoiceMediumScore: $lvlThreeVoiceMediumScore \n lvlTwoEasyScore: $lvlTwoEasyScore \n lvlTwoMediumScore: $lvlTwoMediumScore \n lvlTwoVoiceScore: $lvlTwoVoiceScore \n lvlTwoVoiceMediumScore: $lvlTwoVoiceMediumScore");

    try {
      SignUpResult result =
          await _auth.signUp(username: email, password: password);
      if (result.isSignUpComplete) {
        await _auth.signIn(username: email, password: password);
        AuthUser? user = await getCurrentUser();

        // Create instances of UserData and UserScore
        UserDataType.UserData userData = UserDataType.UserData(
          id: user!.userId,
          name: name,
          age: age,
          school: enumFromString(
              school,
              Schools
                  .values), // Assuming you have a function to convert string to enum
          classname: classname,
          agreement: agreement,
          // Add other fields if necessary
        );

        UserScore userScore = UserScore(
          userdataID: user.userId,
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
          // Add other fields if necessary
        );

        // Update the user data
        await DatabaseService(uid: user.userId)
            .updateUserData(userData, userScore);

        return _userFromCognitoUser(user);
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
    print("we should not be here");
    return null;
  }

  // signout
  Future<void> logOut() async {
    try {
      await _auth.signOut(options: SignOutOptions(globalSignOut: true));
    } on AmplifyException catch (e) {
      print("Exception logging out => ${e.message}");
    }
  }

  /** PRIVATE METHODS: */

  Usr? _userFromCognitoUser(AuthUser? user) {
    return user != null ? Usr(uid: user.userId) : null;
  }

  Future<void> _configureAmplify() async {
    AmplifyDataStore datastorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyStorageS3(),
        datastorePlugin,
        AmplifyAPI()
      ]);
      await Amplify.configure(
          amplifyconfig); // exception thrown here in debug mode
      print('Amplify configured successfully');
    } on AmplifyAlreadyConfiguredException catch (e) {
      print('Amplify was already configured: $e');
    } on SignedOutException catch (e) {
      print('User is already signed out: $e');
    } catch (e) {
      print('An error occurred during Amplify configuration: $e');
      throw e;
    }
  }

  static StreamSubscription _configureHubSubscription() {
    return Amplify.Hub.listen<AuthUser, AuthHubEvent>(HubChannel.Auth,
        (hubEvent) async {
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
          print("Other hub activity is =>  ${hubEvent.eventName}");
      }
    });
  }
}
