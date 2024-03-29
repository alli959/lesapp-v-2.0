import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authenticate/authenticate.dart';
import 'home/welcome.dart';

class Wrapper extends StatelessWidget {
  static const String id = 'wrapper';
  @override
  Widget build(BuildContext context) {
    print("we are at the wrapper widget");
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        return Welcome();
      }
      if (state is AuthenticationUnauthenticated) {
        return Authenticate();
      }
      return Authenticate();
    });
    //   final user = BlocProvider.of<AuthenticationBloc>(context);
    //   if (user == null) {
    //     return Authenticate();
    //   } else {
    //     return Welcome();
    //   }
    // }
  }
}
