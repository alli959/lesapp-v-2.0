import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
import 'package:Lesaforrit/bloc/user/register_bloc.dart';
import 'package:Lesaforrit/components/rounded_button.dart';
import 'package:Lesaforrit/services/auth.dart';
import 'package:Lesaforrit/shared/loading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  static const String id = 'register';
  final List<Map<String, String>> schools;

  Register(this.schools);

  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(authBloc, authService),
      child: RegisterForm(schools: schools),
    );
  }
}

class RegisterForm extends StatefulWidget {
  RegisterForm({required this.schools});

  final List<Map<String, String>> schools;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  List<Map<String, String>> schooljson = [
    {"school": "school"}
  ];
  bool hideTopImage = false;
  late String email;
  late String password;
  late String name;
  late String age;
  late String classname;
  late String school;
  bool agreement = true;
  String? selected;
  String error = '';

  @override
  Widget build(BuildContext context) {
    print("widget SCOOLS = ${widget.schools}");
    schooljson = widget.schools;

    // Ensure there's no duplicate

    final _registerBloc = BlocProvider.of<RegisterBloc>(context);
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);

    _onRegisterButtonPressed() {
      if (_formKey.currentState!.validate()) {
        _registerBloc.add(RegisterWithEmailButtonPressed(
            email: email,
            password: password,
            name: name,
            age: age,
            school: school,
            classname: classname,
            aggreement: agreement));
      } else {
        setState(() {
          hideTopImage = true;
        });
      }
    }

    _onLoginViewButtonPressed() {
      _authBloc.add(LoginScreenToggle());
    }

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Nýskráning', style: TextStyle(color: Colors.black)),
              backgroundColor: Color(0xFFE0FF62),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () {
                      _onLoginViewButtonPressed();
                    },
                    icon: Icon(Icons.face, size: 28),
                    label: Text('Innskráning'),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.grey, width: 0.5)),
                    ))
              ],
            ),
            body: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterFailure) {
                  print("oh no!");
                  print("error: " + state.error);
                  this.error = state.error;
                  this.setState(() => hideTopImage = true);
                }
              },
              child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                if (state is RegisterLoading) {
                  return Loading();
                }

                return Form(
                  key: _formKey, // notum þennan formkey til að validata formið
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Expanded(
                        // tag: 'logo',
                        hideTopImage
                            ? Container()
                            : Container(
                                alignment: Alignment.topCenter,
                                height: 200.0,
                                child: Image.asset(
                                    'assets/images/cat_noshadow.png'),
                              ),
                        // ),
                        Container(
                          padding: EdgeInsets.all(6),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-ZáéíóúýðþæöÁÉÍÓÚÝÐÞÆÖ\s]")),
                            ],
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.center,
                            validator: (value) =>
                                value!.isEmpty ? 'Sláðu inn nafn barns' : null,
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
                                value!.isEmpty ? "Veldu aldur barns" : null,
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
                          child: DropdownButtonFormField2(
                            isExpanded: true,
                            hint: Text(
                              //margin to be in the center of the container
                              '      Veldu skóla barns',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: selected,
                            // menuMaxHeight: 150,
                            alignment: Alignment.center,
                            enableFeedback: true,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              // fontWeight: FontWeight.w500,
                            ),
                            items:
                                // ["1. Byrjandi", "2. Þekkir stafina", "3. Les orð"]
                                schooljson
                                    .map((label) => DropdownMenuItem<String>(
                                          child: Text(
                                            label.keys.first,
                                            textAlign: TextAlign.center,
                                          ),
                                          value: label.keys.first,
                                        ))
                                    .toList(),
                            validator: (value) =>
                                value == null ? 'Veldu skóla barnsins' : null,
                            onChanged: (value) {
                              print("value = $value");
                              setState(() {
                                school = value as String;
                              });
                            },
                            onSaved: (value) {
                              setState(() {
                                selected = value as String;
                              });
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText:
                                    '                             Skóli barns'), //þetta er ba
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  "[-a-zA-Z0-9áéíóúýðþæöÁÉÍÓÚÝÐÞÆÖ._\s]"))
                            ],
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.center,
                            validator: (value) =>
                                value!.isEmpty ? 'Sláðu inn nafn á bekk' : null,
                            onChanged: (value) {
                              setState(() {
                                classname = value;
                              });
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Nafn á bekk'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
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
                          padding: EdgeInsets.all(6),
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
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Lykilorð'),
                          ),
                        ),
                        // Create a checkbox that is checked initially, and a text to the right of it
                        GridView.extent(
                            shrinkWrap: true,
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 2,
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Checkbox(
                                      value: agreement,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          agreement = value ?? false;
                                        });
                                      },
                                    ),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      flex: 2,
                                      child: new Text(
                                        'Ég samþykki að taka þátt í meistaraverkefni á vegum  Háskóla Íslands sem felst í vistun á stigum og hljóðupptökum úr leikjum  í lokaðann gagnagrunn á Íslandi.',
                                        textWidthBasis: TextWidthBasis.parent,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 7, 20, 0),
                                // button that NOT RoundedButton, is small and fits 50% of the screens with
                                // width:
                                //     (MediaQuery.of(context).size.width * 0.5),
                                child: RoundedButton(
                                    title: 'Nýskráning',
                                    colour: buttonColorBlue,
                                    onPressed: state is RegisterLoading
                                        ? () {}
                                        : _onRegisterButtonPressed),
                              ),
                            ]),
                        Center(
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.pink),
                          ),
                        ),
                        hideTopImage
                            ? Container()
                            : Container(
                                child: SizedBox(
                                    height: 50.0,
                                    width: double.infinity,
                                    child: Image.asset(
                                        'assets/images/bottomBar_ye.png',
                                        fit: BoxFit.cover)),
                              ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
  }
}
