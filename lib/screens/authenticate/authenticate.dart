import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/screens/authenticate/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class Authenticate extends StatefulWidget {
//   @override
//   _AuthenticateState createState() => _AuthenticateState();
// }

// class _AuthenticateState extends State<Authenticate> {
//   bool showSignIn = true;
//   void toggleView() {
//     setState(() => showSignIn = !showSignIn); //toggle
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showSignIn) {
//       return SignIn(toggleView: toggleView);
//     } else {
//       return Register(toggleView: toggleView);
//     }
//   }
// }

class Authenticate extends StatelessWidget {
  static const String id = 'Authenticate';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is RegisterScreen) {
        return Register();
      }
      return SignIn();
    });
  }
}
