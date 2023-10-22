import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/bloc/user/login_bloc.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/components/rounded_button.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatelessWidget {
  static const String id = 'sign';
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(authBloc, authService),
      child: SignInForm(),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  String error = '';

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    _onLoginButtonPressed() {
      if (_formKey.currentState!.validate()) {
        _loginBloc
            .add(LoginWithEmailButtonPressed(email: email, password: password));
      }
    }

    _onRegisterViewButtonPressed() {
      _authBloc.add(RegisterScreenToggle());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Skrá inn',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Color(0xFFE0FF62),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                _onRegisterViewButtonPressed();
              },
              icon: Icon(Icons.face, size: 28),
              label: Text('Nýskráning'),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.grey, width: 0.5)),
              ))
        ],
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            print("oh no!");
            this.error = "Rangt Netfang eða Lykilorð";
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoginLoading) {
            return Loading();
          }

          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 100.0,
                      child: Image.asset('assets/images/bear.png'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z0-9.@áéíóúýðþæöÁÉÍÓÚÝÐÞÆÖ]")),
                    ],
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    validator: (value) =>
                        value!.isEmpty ? 'Sláðu inn netfang' : null,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Netfang foreldris'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                          r"[a-zA-Z0-9!@#\$%^&*()_+{}|:<>?\-=\[\]\\;',.áéíóúýðþæöÁÉÍÓÚÝÐÞÆÖ]")),
                    ],
                    obscureText: true, //stjörnur í stað texta
                    textAlign: TextAlign.center,
                    validator: (value) => value!.length < 8
                        ? 'Lykilorð þarf að vera a.m.k 8 stafir'
                        : null,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Lykilorð'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 100),
                  child: RoundedButton(
                      title: 'Skrá inn',
                      colour: Color(0xFF009df4),
                      onPressed: state is LoginLoading
                          ? () {}
                          : _onLoginButtonPressed),
                ),
                Center(
                  child: Text(
                    error,
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
                Container(
                  child: SizedBox(
                      height: 110.0,
                      width: double.infinity,
                      child: Image.asset('assets/images/bottomBar_ye.png',
                          fit: BoxFit.cover)),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
