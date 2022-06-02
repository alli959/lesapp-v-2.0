import 'package:Lesaforrit/bloc/database/database_bloc.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/screens/level_one_voice.dart';
import 'package:Lesaforrit/screens/level_three_voice.dart';
import 'package:Lesaforrit/screens/level_two_voice.dart';
import 'package:Lesaforrit/screens/settings.dart';
import 'package:Lesaforrit/services/get_data.dart';
import 'package:Lesaforrit/services/save_audio.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/services.dart';
import 'package:Lesaforrit/router/app_router.dart';
import 'package:Lesaforrit/screens/authenticate/register.dart';
import 'package:Lesaforrit/screens/authenticate/sign_in.dart';
import 'package:Lesaforrit/screens/home/score_chart.dart';
import 'package:Lesaforrit/models/set_score.dart';
import 'package:Lesaforrit/screens/home/welcome.dart';
import 'package:Lesaforrit/screens/level_one_cap.dart';
import 'package:Lesaforrit/screens/level_one_caps_finish.dart';
import 'package:Lesaforrit/screens/level_three.dart';
import 'package:Lesaforrit/screens/level_three_finish.dart';
import 'package:Lesaforrit/screens/level_three_short.dart';
import 'package:Lesaforrit/screens/level_two_finish.dart';
import 'package:Lesaforrit/screens/level_two_short.dart';
import 'package:Lesaforrit/screens/lvlOne_choose.dart';
import 'package:Lesaforrit/screens/lvlThree_choose.dart';
import 'package:Lesaforrit/screens/lvlTwo_choose.dart';
import 'package:Lesaforrit/screens/my_profile.dart';
import 'package:Lesaforrit/screens/profile_view.dart';
import 'package:Lesaforrit/screens/wrapper.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_speech/google_speech.dart';
import 'models/ModelProvider.dart';
import 'models/levelTemplate.dart';
import 'package:Lesaforrit/screens/level_one.dart';
import 'package:Lesaforrit/screens/level_one_finish.dart';
import 'package:Lesaforrit/screens/level_two.dart';
import 'amplifyconfiguration.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   HydratedBloc.storage = await HydratedStorage.build(
//       storageDirectory: await getApplicationDocumentsDirectory());
//   await Firebase.initializeApp();
//   runApp(Lesapp(
//     appRouter: AppRouter(),
//     connectivity: Connectivity(),
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final serviceAccount = ServiceAccount.fromString((await rootBundle
      .loadString('assets/graphite-flare-324114-285b1cf5c32b.json')));
  SpeechToText speech = SpeechToText.viaServiceAccount(serviceAccount);

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthService>(create: (context) {
          return AuthService();
        }),
        RepositoryProvider(create: (context) {
          return DatabaseService();
        }),
        RepositoryProvider<VoiceService>(create: (context) {
          return VoiceService(speech: speech, context: context);
        }),
        RepositoryProvider<GetData>(create: (context) {
          return GetData("sentences", "easy");
        }),
        RepositoryProvider<SaveAudio>(create: (context) {
          return SaveAudio("username", "Correct", "question", "answer", null);
        }),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            final authService = RepositoryProvider.of<AuthService>(context);
            return AuthenticationBloc(authService)..add(AppStarted());
          },
        ),
        BlocProvider<DatabaseBloc>(
          create: (context) {
            final databaseService =
                RepositoryProvider.of<DatabaseService>(context);
            return DatabaseBloc(databaseService);
          },
        ),
      ], child: lesApp(appRouter: AppRouter()))));
}

class lesApp extends StatelessWidget {
  final AppRouter appRouter;

  const lesApp({
    Key key,
    @required this.appRouter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    final databaseRepo = RepositoryProvider.of<DatabaseService>(context);
    // _databaseBloc.add(SetUserID(Uid: state.usr.uid));

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is UserUid) {
        print("state is userUID !!!!!!! => ${state.uid}");
        databaseRepo.setUid(state.uid);
      }
      return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFE0FF62), // Litur á appbari uppi
          scaffoldBackgroundColor: Color(0xFFE0FF62), // litur á scaffold niðri
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
        initialRoute: Wrapper.id,
        routes: {
          Welcome.id: (context) => Welcome(),
          ScoreChart.id: (context) => ScoreChart(),
          LvlOneChoose.id: (context) => LvlOneChoose(),
          LvlTwoChoose.id: (context) => LvlTwoChoose(),
          LvlThreeChoose.id: (context) => LvlThreeChoose(),
          LevelTemplate.id: (context) => LevelTemplate(),
          LevelOne.id: (context) => LevelOne(),
          LevelOneCap.id: (context) => LevelOneCap(),
          LevelOneVoice.id: (context) => LevelOneVoice(),
          LevelTwo.id: (context) => LevelTwo(),
          LevelTwoShort.id: (context) => LevelTwoShort(),
          LevelTwoVoice.id: (contraxt) => LevelTwoVoice(),
          LevelThree.id: (context) => LevelThree(),
          LevelThreeShort.id: (context) => LevelThreeShort(),
          LevelThreeVoice.id: (context) => LevelThreeVoice(),
          OneFinish.id: (context) => OneFinish(),
          OneCapsFinish.id: (context) => OneCapsFinish(),
          TwoFinish.id: (context) => TwoFinish(),
          ThreeFinish.id: (context) => ThreeFinish(),
          SignIn.id: (context) => SignIn(),
          Register.id: (context) => Register(),
          Wrapper.id: (context) => Wrapper(),
          ProfileView.id: (context) => ProfileView(),
          MyProfile.id: (context) => MyProfile(),
          SetScore.id: (context) => SetScore(),
          Settings.id: (context) => Settings(),
        },
      );
    });
  }
}


// class Lesapp extends StatelessWidget {
//   final AppRouter appRouter;
//   final Connectivity connectivity;

//   const Lesapp({
//     Key key,
//     this.appRouter,
//     this.connectivity,
//   }) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return MultiBlocProvider(
  //       providers: [
  //         Listener(WrapperCubit)
  //       ],
  //       child: MaterialApp(
  //         title: 'Flutter Demo',
  //         theme: ThemeData(
  //           primaryColor: Color(0xFFE0FF62), // Litur á appbari uppi
  //           scaffoldBackgroundColor:
  //               Color(0xFFE0FF62), // litur á scaffold niðri
  //         ),
  //         onGenerateRoute: appRouter.onGenerateRoute,
  //       )
  //   );
  // }

  // Widget build(BuildContext context) {
  //   // Þurfum að tilgreina hvaða provider við ætlum að hlusta á..
  //   // Þetta þýðir að öll widgetin fyrir neðan hafa aðgang að gögnum sem koma úr þessum stream.
  //   return BlocProvider<Usr>(
  //     create: (UsrCubit) =>
  //       UsrCubit()
  //     value: AuthService().user,
  //     child: MaterialApp(
  //       theme: ThemeData(
  //         primaryColor: Color(0xFFE0FF62), // Litur á appbari uppi
  //         scaffoldBackgroundColor: Color(0xFFE0FF62), // litur á scaffold niðri
  //       ),
  //       debugShowCheckedModeBanner: false,
  //       initialRoute: Wrapper.id,
  //       routes: {
  //         Welcome.id: (context) => Welcome(),
  //         ScoreChart.id: (context) => ScoreChart(),
  //         LvlOneChoose.id: (context) => LvlOneChoose(),
  //         LvlTwoChoose.id: (context) => LvlTwoChoose(),
  //         LvlThreeChoose.id: (context) => LvlThreeChoose(),
  //         LevelTemplate.id: (context) => LevelTemplate(),
  //         LevelOne.id: (context) => LevelOne(),
  //         LevelOneCap.id: (context) => LevelOneCap(),
  //         LevelTwo.id: (context) => LevelTwo(),
  //         LevelTwoShort.id: (context) => LevelTwoShort(),
  //         LevelFinish.id: (context) => LevelFinish(),
  //         LevelThree.id: (context) => LevelThree(),
  //         LevelThreeShort.id: (context) => LevelThreeShort(),
  //         OneFinish.id: (context) => OneFinish(),
  //         OneCapsFinish.id: (context) => OneCapsFinish(),
  //         TwoFinish.id: (context) => TwoFinish(),
  //         ThreeFinish.id: (context) => ThreeFinish(),
  //         SignIn.id: (context) => SignIn(),
  //         Register.id: (context) => Register(),
  //         Wrapper.id: (context) => Wrapper(),
  //         ProfileView.id: (context) => ProfileView(),
  //         MyProfile.id: (context) => MyProfile(),
  //         SetScore.id: (context) => SetScore(),
  //       },
  //     ),
  //   );
  // }
  // // Widget build(BuildContext context) {
  //   // Þurfum að tilgreina hvaða provider við ætlum að hlusta á..
  //   // Þetta þýðir að öll widgetin fyrir neðan hafa aðgang að gögnum sem koma úr þessum stream.
    // return StreamProvider<Usr>.value(
    //   value: AuthService().user,
    //   child: MaterialApp(
    //     theme: ThemeData(
    //       primaryColor: Color(0xFFE0FF62), // Litur á appbari uppi
    //       scaffoldBackgroundColor: Color(0xFFE0FF62), // litur á scaffold niðri
    //     ),
    //     debugShowCheckedModeBanner: false,
    //     initialRoute: Wrapper.id,
    //     routes: {
    //       Welcome.id: (context) => Welcome(),
    //       ScoreChart.id: (context) => ScoreChart(),
    //       LvlOneChoose.id: (context) => LvlOneChoose(),
    //       LvlTwoChoose.id: (context) => LvlTwoChoose(),
    //       LvlThreeChoose.id: (context) => LvlThreeChoose(),
    //       LevelTemplate.id: (context) => LevelTemplate(),
    //       LevelOne.id: (context) => LevelOne(),
    //       LevelOneCap.id: (context) => LevelOneCap(),
    //       LevelTwo.id: (context) => LevelTwo(),
    //       LevelTwoShort.id: (context) => LevelTwoShort(),
    //       LevelFinish.id: (context) => LevelFinish(),
    //       LevelThree.id: (context) => LevelThree(),
    //       LevelThreeShort.id: (context) => LevelThreeShort(),
    //       OneFinish.id: (context) => OneFinish(),
    //       OneCapsFinish.id: (context) => OneCapsFinish(),
    //       TwoFinish.id: (context) => TwoFinish(),
    //       ThreeFinish.id: (context) => ThreeFinish(),
    //       SignIn.id: (context) => SignIn(),
    //       Register.id: (context) => Register(),
    //       Wrapper.id: (context) => Wrapper(),
    //       ProfileView.id: (context) => ProfileView(),
    //       MyProfile.id: (context) => MyProfile(),
    //       SetScore.id: (context) => SetScore(),
    //     },
    //   ),
    // );
