import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/bloc/user/register_bloc.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/rounded_button.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  static const String id = 'register';

  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(authBloc, authService),
      child: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email;
  String password;
  String name;
  String age;
  String readingStage;
  String selected;
  String error = '';

  @override
  Widget build(BuildContext context) {
    final _registerBloc = BlocProvider.of<RegisterBloc>(context);
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);

    _onRegisterButtonPressed() {
      if (_formKey.currentState.validate()) {
        _registerBloc.add(RegisterWithEmailButtonPressed(
            email: email,
            password: password,
            name: name,
            age: age,
            readingStage: readingStage));
      }
    }

    _onLoginViewButtonPressed() {
      _authBloc.add(LoginScreenToggle());
    }

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Nýskráning'),
              backgroundColor: Color(0xFFE0FF62),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      _onLoginViewButtonPressed();
                    },
                    icon: Icon(Icons.face),
                    label: Text('Skrá inn'))
              ],
            ),
            body: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterFailure) {
                  print("oh no!");
                }
              },
              child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                if (state is RegisterLoading) {
                  return Loading();
                }

                return Form(
                  key: _formKey, // notum þennan formkey til að validata formið
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            height: 100.0,
                            child:
                                Image.asset('assets/images/cat_noshadow.png'),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          validator: (value) =>
                              value.isEmpty ? 'Sláðu inn nafn barns' : null,
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Nafn barns'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          validator: (value) =>
                              value.isEmpty ? 'Veldu aldur barns' : null,
                          onChanged: (value) {
                            setState(() {
                              age = value;
                            });
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Aldur barns'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: DropdownButtonFormField<String>(
                          validator: (value) => value.isEmpty
                              ? 'Veldu lestrarstig barnsins'
                              : null,
                          value: selected,
                          items:
                              ["1. Byrjandi", "2. Þekkir stafina", "3. Les orð"]
                                  .map((label) => DropdownMenuItem(
                                        child: Text(
                                          label,
                                          textAlign: TextAlign.center,
                                        ),
                                        value: label,
                                      ))
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              readingStage = value;
                            });
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText:
                                '                   Veldu lestrarstig barnsins',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          validator: (value) =>
                              value.isEmpty ? 'Sláðu inn netfang' : null,
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
                        padding: EdgeInsets.all(6),
                        child: TextFormField(
                          obscureText: true, //stjörnur í stað texta
                          textAlign: TextAlign.center,
                          validator: (value) => value.length < 8
                              ? 'Lykilorð þarf að vera a.m.k 8 stafir'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Lykilorð'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 7, 20, 0),
                        child: RoundedButton(
                            title: 'Nýskráning',
                            colour: buttonColorBlue,
                            onPressed: state is RegisterLoading
                                ? () {}
                                : _onRegisterButtonPressed),
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
