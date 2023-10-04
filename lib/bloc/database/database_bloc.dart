import 'dart:convert';

import 'package:Lesaforrit/services/databaseService.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../models/PrefVoice.dart';
import '../../models/Schools.dart';
import '../../models/UserData.dart';
import '../../models/UserScore.dart';
import '../../models/read.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseService _databaseService;
  DatabaseBloc(DatabaseService databaseService)
      : _databaseService = databaseService,
        super(DatabaseInitial());

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event) async* {
    if (event is UpdateUserData) {
      yield* _mapUpdateUserDataToState(event);
    }
    if (event is SetUserID) {
      yield* _mapSetUserID(event);
    }

    if (event is UpdateUserScore) {
      yield* _mapUpdateUserScoreToState(event);
    }
    if (event is GetUserData) {
      yield* _mapUserDataToState(event);
    }
    if (event is GetUsers) {
      yield* _mapUsersToState(event);
    }
    if (event is GetSpecialData) {
      yield* _mapSpecialDataToState(event);
    }
    if (event is ActionPerformedEvent) {
      yield* _mapActionPerformedEventToState(event);
    }
    if (event is SaveSpecialData) {
      yield* _mapSaveSpecialData(event);
    }
  }

  Stream<DatabaseState> _mapUpdateUserDataToState(UpdateUserData event) async* {
    yield DatabaseLoading();

    try {
      UserData userData = UserData(
          id: _databaseService.uid, // Assuming you have access to uid
          name: event.name,
          age: event.age,
          school: enumFromString(
              event.school,
              Schools
                  .values), // Assuming you have a function to convert string to enum
          classname: event.classname,
          prefVoice: PrefVoice.DORA, // Default value, modify as needed
          agreement: event.agreement,
          saveRecord:
              event.agreement, // Assuming saveRecord is same as agreement
          manualFix: false // Default value, modify as needed
          );
      await _databaseService.updateUserData(userData, null);

      yield UserDataUpdate(userData: userData);
    } catch (e) {
      yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapSetUserID(SetUserID event) async* {
    yield DatabaseLoading();
    _databaseService.setUid(event.Uid);
  }

  Stream<DatabaseState> _mapUpdateUserScoreToState(
      UpdateUserScore event) async* {
    print("score in bloc is ${event.score}");
    yield DatabaseLoading();

    try {
      // check if it is a new record
      bool isNewRecord = false;
      double maxScore =
          await _databaseService.getMaxSpecificValue(event.typeof);
      if (maxScore > event.score) {
        isNewRecord = false;
      } else {
        isNewRecord = true;
      }

      // Create an instance of UserScore
      UserScore userScore = UserScore(
        userdataID: _databaseService.uid, // Assuming you have access to uid
        // Set all scores to null by default
        lvlOneCapsScore: event.typeof == "lvlOneCapsScore" ? event.score : null,
        lvlOneScore: event.typeof == "lvlOneScore" ? event.score : null,
        lvlOneVoiceScore:
            event.typeof == "lvlOneVoiceScore" ? event.score : null,
        lvlThreeEasyScore:
            event.typeof == "lvlThreeEasyScore" ? event.score : null,
        lvlThreeMediumScore:
            event.typeof == "lvlThreeMediumScore" ? event.score : null,
        lvlThreeVoiceScore:
            event.typeof == "lvlThreeVoiceScore" ? event.score : null,
        lvlThreeVoiceMediumScore:
            event.typeof == "lvlThreeVoiceMediumScore" ? event.score : null,
        lvlTwoEasyScore: event.typeof == "lvlTwoEasyScore" ? event.score : null,
        lvlTwoMediumScore:
            event.typeof == "lvlTwoMediumScore" ? event.score : null,
        lvlTwoVoiceScore:
            event.typeof == "lvlTwoVoiceScore" ? event.score : null,
        lvlTwoVoiceMediumScore:
            event.typeof == "lvlTwoVoiceMediumScore" ? event.score : null,
      );

      // Update score
      await _databaseService.updateUserScore(userScore);

      yield IsNewRecord(newRecord: isNewRecord, record: maxScore);
      // Stream<UserData> userData = await _databaseService.userData;

      // yield UserScoreUpdate(userData: userData);
    } catch (e) {
      yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapUserDataToState(GetUserData event) async* {
    yield DatabaseLoading();

    try {
      UserData userData = await _databaseService.getUserData();
      UserScore userScore = await _databaseService.getUserScores();
      var schools = await rootBundle.loadString('assets/Schools.json');
      Map<String, dynamic> schoolsList = json.decode(schools);

      String schoolID = userData.school!.name;

      String school = schoolsList[schoolID];
      print("school is => $school");

      yield UserDataState(
          userdata: userData, userscore: userScore, school: school);
    } catch (e) {
      yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapUsersToState(GetUsers event) async* {
    yield DatabaseLoading();
    try {
      Stream<List<Read>> users = await DatabaseService(uid: '').users;
      yield UsersState(users: users);
    } catch (e) {
      yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapSpecialDataToState(GetSpecialData event) async* {
    yield DatabaseLoading();
    try {
      var data = await _databaseService.GetSpecialData();
      PrefVoice prefVoice = data["prefVoice"] ?? PrefVoice.DORA;
      bool saveRecord = data["saveRecord"] ?? true;
      bool manualFix = data["manualFix"] ?? false;
      bool agreement = data["agreement"];
      String classname = data["classname"];
      String name = data["name"];
      String age = data["age"];

      String schoolname =
          await _databaseService.getSchoolNameFromID(data["school"]);
      List<String> schoolnamelist = await _databaseService.getAllSchoolNames();
      yield SpecialDataState(
          prefVoice: prefVoice,
          saveRecord: saveRecord,
          manualFix: manualFix,
          agreement: agreement,
          schoolname: schoolname,
          classname: classname,
          name: name,
          age: age,
          schoolnamelist: schoolnamelist);
    } catch (err) {
      print("there was an error in the database $err");
    }
  }

  Stream<DatabaseState> _mapSaveSpecialData(SaveSpecialData event) async* {
    print("SCHOOL NAME IS => ${event.schoolname}");
    Schools schoolID =
        await _databaseService.getSchoolIDFromName(event.schoolname);

    print("Schoolid is ${schoolID.toString()}");
    try {
      // Create an instance of UserData
      UserData userData = UserData(
        name: event.name,
        age: event.age,
        school: schoolID,
        classname: event.classname,
        agreement: event.agreement,
        prefVoice: event.prefVoice,
        saveRecord: event.saveRecord,
        manualFix: event.manualFix,
        UserScores: [], // Assuming you want to initialize with an empty list
        // Add other fields if necessary
      );

      // Save the special data
      await _databaseService.saveSpecialData(userData);

      // You can yield a success state here if you have one
      // yield SpecialDataSaved();
    } catch (err) {
      print("there was an error saving special data $err");
      // You can yield an error state here if you have one
      // yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapActionPerformedEventToState(
      ActionPerformedEvent event) async* {
    yield ActionPerformedState(
        prefVoice: event.prefVoice,
        saveRecord: event.saveRecord,
        manualFix: event.manualFix,
        agreement: event.agreement,
        schoolname: event.schoolname,
        classname: event.classname,
        name: event.name,
        age: event.age);
  }
}
