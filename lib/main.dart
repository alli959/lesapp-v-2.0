import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/screens/level_three_voice.dart';
import 'package:Lesaforrit/services/voiceService.dart';
import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';
import 'package:Lesaforrit/router/app_router.dart';
import 'package:Lesaforrit/screens/authenticate/register.dart';
import 'package:Lesaforrit/screens/authenticate/sign_in.dart';
import 'package:Lesaforrit/screens/home/score_chart.dart';
import 'package:Lesaforrit/models/set_score.dart';
import 'package:Lesaforrit/screens/home/welcome.dart';
import 'package:Lesaforrit/screens/level_finish.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'models/levelTemplate.dart';
import 'models/usr.dart';
import 'package:Lesaforrit/screens/level_one.dart';
import 'package:Lesaforrit/screens/level_one_finish.dart';
import 'package:Lesaforrit/screens/level_two.dart';
import 'package:flutter/foundation.dart';

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
  // S3 IMPORT
  const region = "eu-west-1";
  const bucketId = "lesapp-data";
  final AwsS3Client s3client = AwsS3Client(
      region: region,
      host: "s3.$region.amazonaws.com",
      bucketId: bucketId,
      accessKey: "AKIA3TGGOOO6EHBNOH7W",
      secretKey: "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");

  final listBucketResult =
      await s3client.listObjects(prefix: "assets/sound/", delimiter: "/");
  print("below is bucketresult");
  print(listBucketResult.toString());

  final response = await s3client.getObject("assets/sound/a.mp3");
  print("below is body");
  print(response.body.toString());

  final SpeechToText speech = SpeechToText();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ],
      child: BlocProvider<AuthenticationBloc>(
          create: (context) {
            final authService = RepositoryProvider.of<AuthService>(context);
            return AuthenticationBloc(authService)..add(AppStarted());
          },
          child: lesApp(
            appRouter: AppRouter(),
          ))));
}

class lesApp extends StatelessWidget {
  final AppRouter appRouter;

  const lesApp({
    Key key,
    @required this.appRouter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
        LevelTwo.id: (context) => LevelTwo(),
        LevelTwoShort.id: (context) => LevelTwoShort(),
        LevelFinish.id: (context) => LevelFinish(),
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
      },
    );
    // return StreamProvider<Usr>.value(
    //   value: AuthService().user,
    //   child: MaterialApp(
    //     theme: ThemeData(
    //       primaryColor: Color(0xFFE0FF62), // Litur á appbari uppi
    //       scaffoldBackgroundColor: Color(0xFFE0FF62), // litur á scaffold niðri
    //     ),
    //     onGenerateRoute: appRouter.onGenerateRoute,
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
