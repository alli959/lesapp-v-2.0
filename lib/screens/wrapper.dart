import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Lesaforrit/models/user.dart';
import 'authenticate/authenticate.dart';
import 'home/welcome.dart';

class Wrapper extends StatelessWidget {
  static const String id = 'wrapper';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Welcome();
    }
  }
}
