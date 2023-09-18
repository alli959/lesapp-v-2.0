// import 'package:Lesaforrit/bloc/user/authentication_bloc.dart';
// import 'package:Lesaforrit/bloc/user/register_bloc.dart';
// import 'package:Lesaforrit/components/rounded_button.dart';
// import 'package:Lesaforrit/services/auth.dart';
// import 'package:Lesaforrit/shared/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:Lesaforrit/shared/constants.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Register extends StatelessWidget {
//   static const String id = 'register';
//   final List<Map<String, String>> schools;

//   Register(this.schools);

//   Widget build(BuildContext context) {
//     final authService = RepositoryProvider.of<AuthService>(context);
//     final authBloc = BlocProvider.of<AuthenticationBloc>(context);

//     return BlocProvider<RegisterBloc>(
//       create: (context) => RegisterBloc(authBloc, authService),
//       child: RegisterForm(schools: schools),
//     );
//   }
// }

// class RegisterForm extends StatefulWidget {
//   RegisterForm({this.schools});

//   final List<Map<String, String>> schools;

//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<RegisterForm> {
//   final _formKey = GlobalKey<FormState>();
//   bool loading = false;
//   List<Map<String, String>> schooljson = [
//     {"school": "school"}
//   ];
//   String email;
//   String password;
//   String name;
//   String age;
//   String classname;
//   String school;
//   bool agreement;
//   String selected;
//   String error = '';

//   @override
//   Widget build(BuildContext context) {
//     print("widget SCOOLS = ${widget.schools}");
//     schooljson = widget.schools;

//     final _registerBloc = BlocProvider.of<RegisterBloc>(context);
//     final _authBloc = BlocProvider.of<AuthenticationBloc>(context);

//     _onRegisterButtonPressed() {
//       if (_formKey.currentState.validate()) {
//         _registerBloc.add(RegisterWithEmailButtonPressed(
//             email: email,
//             password: password,
//             name: name,
//             age: age,
//             school: school,
//             classname: classname,
//             aggreement: agreement));
//       }
//     }

//     _onLoginViewButtonPressed() {
//       _authBloc.add(LoginScreenToggle());
//     }

//     return loading
//         ? Loading()
//         : Scaffold(
//             appBar: AppBar(
//               title: Text('Nýskráning', style: TextStyle(color: Colors.black)),
//               backgroundColor: Color(0xFFE0FF62),
//               automaticallyImplyLeading: false,
//               actions: <Widget>[
//                 TextButton.icon(
//                     onPressed: () {
//                       _onLoginViewButtonPressed();
//                     },
//                     icon: Icon(Icons.face, size: 28),
//                     label: Text('Innskráning'),
//                     style: TextButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           side: BorderSide(color: Colors.grey, width: 0.5)),
//                     ))
//               ],
//             ),
//             body: BlocListener<RegisterBloc, RegisterState>(
//               listener: (context, state) {
//                 if (state is RegisterFailure) {
//                   print("oh no!");
//                   print("error: " + state.error);
//                   this.error = state.error;
//                 }
//               },
//               child: BlocBuilder<RegisterBloc, RegisterState>(
//                   builder: (context, state) {
//                 if (state is RegisterLoading) {
//                   return Loading();
//                 }

//                 return Form(
//                   key: _formKey, // notum þennan formkey til að validata formið
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     //crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       Expanded(
//                         child: Hero(
//                           tag: 'logo',
//                           child: Container(
//                             height: 60.0,
//                             child:
//                                 Image.asset('assets/images/cat_noshadow.png'),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(6),
//                         child: TextFormField(
//                           keyboardType: TextInputType.name,
//                           textAlign: TextAlign.center,
//                           validator: (value) =>
//                               value.isEmpty ? 'Sláðu inn nafn barns' : null,
//                           onChanged: (value) {
//                             setState(() {
//                               name = value;
//                             });
//                           },
//                           decoration: kTextFieldDecoration.copyWith(
//                               hintText: 'Nafn barns'),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(6),
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           textAlign: TextAlign.center,
//                           validator: (value) =>
//                               value.isEmpty ? 'Veldu aldur barns' : null,
//                           onChanged: (value) {
//                             setState(() {
//                               age = value;
//                             });
//                           },
//                           decoration: kTextFieldDecoration.copyWith(
//                               hintText: 'Aldur barns'),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(6),
//                         child: DropdownButtonFormField<String>(
//                           isExpanded: true,
//                           validator: (value) =>
//                               value.isEmpty ? 'Veldu skóla barnsins' : null,
//                           value: selected,
//                           menuMaxHeight: 150,
//                           alignment: Alignment.center,
//                           enableFeedback: true,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           items:
//                               // ["1. Byrjandi", "2. Þekkir stafina", "3. Les orð"]
//                               schooljson
//                                   .map((label) => DropdownMenuItem(
//                                         child: Text(
//                                           label.keys.first,
//                                           textAlign: TextAlign.center,
//                                         ),
//                                         value: label.keys.first,
//                                       ))
//                                   .toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               school = value;
//                             });
//                           },
//                           decoration: kTextFieldDecoration.copyWith(
//                             hintText:
//                                 '                             Skóli barns', //þetta er bara til að hafa textann í miðju
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(6),
//                         child: TextFormField(
//                           keyboardType: TextInputType.emailAddress,
//                           textAlign: TextAlign.center,
//                           validator: (value) =>
//                               value.isEmpty ? 'Sláðu inn netfang' : null,
//                           onChanged: (value) {
//                             setState(() {
//                               email = value;
//                             });
//                           },
//                           decoration: kTextFieldDecoration.copyWith(
//                               hintText: 'Netfang foreldris'),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(6),
//                         child: TextFormField(
//                           obscureText: true, //stjörnur í stað texta
//                           textAlign: TextAlign.center,
//                           validator: (value) => value.length < 8
//                               ? 'Lykilorð þarf að vera a.m.k 8 stafir'
//                               : null,
//                           onChanged: (value) {
//                             setState(() {
//                               password = value;
//                             });
//                           },
//                           decoration: kTextFieldDecoration.copyWith(
//                               hintText: 'Lykilorð'),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.fromLTRB(20, 7, 20, 0),
//                         child: RoundedButton(
//                             title: 'Nýskráning',
//                             colour: buttonColorBlue,
//                             onPressed: state is RegisterLoading
//                                 ? () {}
//                                 : _onRegisterButtonPressed),
//                       ),
//                       Center(
//                         child: Text(
//                           error,
//                           style: TextStyle(color: Colors.pink),
//                         ),
//                       ),
//                       Container(
//                         child: SizedBox(
//                             height: 110.0,
//                             width: double.infinity,
//                             child: Image.asset('assets/images/bottomBar_ye.png',
//                                 fit: BoxFit.cover)),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ),
//           );
//   }
// }
