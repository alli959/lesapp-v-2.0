import 'package:Lesaforrit/bloc/database/database_bloc.dart';
import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/screens/settings.dart';
import 'package:Lesaforrit/services/audio_session.dart';
import 'package:Lesaforrit/services/get_data.dart';
import 'package:Lesaforrit/services/save_audio.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:flutter/services.dart';
import 'package:Lesaforrit/router/app_router.dart';
import 'package:Lesaforrit/screens/authenticate/register.dart';
import 'package:Lesaforrit/screens/authenticate/sign_in.dart';
import 'package:Lesaforrit/screens/home/score_chart.dart';
import 'package:Lesaforrit/models/set_score.dart';
import 'package:Lesaforrit/screens/home/welcome.dart';
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
import 'models/levelTemplate.dart';
import 'shared/constants.dart';

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
  // add these lines
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final serviceAccount = ServiceAccount.fromString((await rootBundle
      .loadString('assets/graphite-flare-324114-285b1cf5c32b.json')));
  SpeechToText speech = SpeechToText.viaServiceAccount(serviceAccount);

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthService>(create: (context) {
          return AuthService();
        }),
        RepositoryProvider(create: (context) {
          return DatabaseService(uid: '');
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
        RepositoryProvider<AudioSessionService>(create: (context) {
          return AudioSessionService(uid: '')..init();
        })
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
    Key? key,
    required this.appRouter,
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
        databaseRepo.setUid(state.uid ?? '');
      }
      return MaterialApp(
          theme: ThemeData(
            primaryColor: appBar, // Litur á appbari uppi
            scaffoldBackgroundColor: guli, // litur á scaffold niðri
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: Wrapper.id,
          routes: {
            Welcome.id: (context) => Welcome(),
            ScoreChart.id: (context) => ScoreChart(),
            LvlOneChoose.id: (context) => LvlOneChoose(),
            LvlTwoChoose.id: (context) => LvlTwoChoose(),
            LvlThreeChoose.id: (context) => LvlThreeChoose(),
            LevelTemplate.id: (context) => LevelTemplate(),
            SignIn.id: (context) => SignIn(),
            Register.id: (context) => Register([
                  {"school": "school"}
                ]),
            Wrapper.id: (context) => Wrapper(),
            ProfileView.id: (context) => ProfileView(),
            MyProfile.id: (context) => MyProfile(),
            SetScore.id: (context) => SetScore(),
            Settings.id: (context) => Settings(),
          },
          onGenerateRoute: appRouter.onGenerateRoute);
    });
  }
}
