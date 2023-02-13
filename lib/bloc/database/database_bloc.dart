import 'dart:convert';

import 'package:Lesaforrit/models/usr.dart' as usr;
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

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
      : assert(databaseService != null),
        _databaseService = databaseService,
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
      dynamic userData = await _databaseService.updateUserData(
          event.name,
          event.age,
          event.school,
          event.classname,
          event.agreement,
          event.lvlOneCapsScore,
          event.lvlOneScore,
          event.lvlOneVoiceScore,
          event.lvlThreeEasyScore,
          event.lvlThreeMediumScore,
          event.lvlThreeVoiceScore,
          event.lvlThreeVoiceMediumScore,
          event.lvlTwoEasyScore,
          event.lvlTwoMediumScore,
          event.lvlTwoVoiceScore,
          event.lvlTwoVoiceMediumScore);

      if (userData != null) {
        yield UserDataUpdate(userData: userData);
      }
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
      await _databaseService.updateUserScore(event.score, event.typeof);
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

      String schoolID = userData.school.name;

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
      Stream<List<Read>> users = await DatabaseService().users;
      yield UsersState(users: users);
    } catch (e) {
      yield DatabaseFailure();
    }
  }

  Stream<DatabaseState> _mapSpecialDataToState(GetSpecialData event) async* {
    yield DatabaseLoading();
    try {
      var data = await _databaseService.GetSpecialData();
      PrefVoice prefVoice = data["prefVoice"];
      bool saveRecord = data["saveRecord"];
      bool manualFix = data["manualFix"];
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
      await _databaseService.saveSpecialData(
          event.prefVoice,
          event.saveRecord,
          event.manualFix,
          event.classname,
          schoolID,
          event.agreement,
          event.name,
          event.age);
    } catch (err) {
      print("there was an error saving special data $err");
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
