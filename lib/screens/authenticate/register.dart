import 'package:Lesaforrit/components/bottom_bar.dart';
import 'package:Lesaforrit/components/rounded_button.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/services/databaseService.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';

class Register extends StatefulWidget {
  static const String id = 'register';
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email;
  String password;
  String error = '';
  String name;
  String age;
  String readingStage;
  String score = '0';
  String scoreCaps = '0';
  String scoreTwo = '0';
  String scoreTwoLong = '0';
  String scoreThree = '0';
  String scoreThreeLong = '0';
  String selected;

  @override
  Widget build(BuildContext context) {
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
                      widget.toggleView();
                    },
                    icon: Icon(Icons.face),
                    label: Text('Skrá inn'))
              ],
            ),
            body: Form(
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
                        child: Image.asset('assets/images/cat_noshadow.png'),
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
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Nafn barns'),
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
                      validator: (value) =>
                          value.isEmpty ? 'Veldu lestrarstig barnsins' : null,
                      value: selected,
                      items: ["1. Byrjandi", "2. Þekkir stafina", "3. Les orð"]
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
                    padding: EdgeInsets.fromLTRB(20, 7, 20, 0),
                    child: RoundedButton(
                      title: 'Nýskráning',
                      colour: buttonColorBlue,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  email,
                                  password,
                                  name,
                                  score,
                                  scoreCaps,
                                  age,
                                  readingStage,
                                  scoreTwo,
                                  scoreTwoLong,
                                  scoreThree,
                                  scoreThreeLong);
                          if (result == null) {
                            setState(() {
                              error = 'Skráið gilt netfang';
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
