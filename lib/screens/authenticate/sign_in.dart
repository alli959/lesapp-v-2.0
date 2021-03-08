import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/components/rounded_button.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:Lesaforrit/components/bottom_bar.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  static const String id = 'sign';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email;
  String password;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Skrá inn'),
              backgroundColor: Color(0xFFE0FF62),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.face),
                    label: Text('Nýskráning'))
              ],
            ),
            body: Form(
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
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      obscureText: true, //stjörnur í stað texta
                      textAlign: TextAlign.center,
                      validator: (value) => value.length < 6
                          ? 'Lykilorð þarf að vera a.m.k 6 stafir'
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
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error =
                                  'Gat ekki skráð notanda inn með þessum gögnum';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
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
            ),
          );
  }
}

/*
            child: RoundedButton(
              title: 'Skrá inn',
              colour: Color(0xFF009df4),
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print('error signing in');
                } else {
                  print('signed in');
                  print(result.uid);
                }
              },
            ),
 */
