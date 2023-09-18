import 'package:flutter/material.dart';
import '../models/ModelProvider.dart';

class UpdateInfo extends StatelessWidget {
  String _name;
  Schools _school;
  String _class;
  String age;
  final Function? onTapApprove;

  UpdateInfo({
    String? name,
    Schools? school,
    String? classname,
    String? age,
    this.onTapApprove,
  })  : _name = name ?? '',
        _class = classname ?? '',
        _school = school ?? Schools.School1,
        age = age ?? '';

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Nafn barns'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vinsamlegast fyllið út nafn';
                }
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: _school.name,
              decoration: InputDecoration(labelText: 'Skóli'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vinsamlegast fyllið út skóla';
                }
                return null;
              },
              onSaved: (value) => _school = Schools.values
                  .firstWhere((e) => e.toString() == 'Schools.$value'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: _class,
              decoration: InputDecoration(labelText: 'Bekkur'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vinsamlegast fyllið út bekki';
                }
                return null;
              },
              onSaved: (value) => _class = value!,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: age,
              decoration: InputDecoration(labelText: 'aldur barns'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vinsamlegast fyllið út aldur barns';
                }
                return null;
              },
              onSaved: (value) => age = value!,
            ),
          ),
        ],
      ),
    );
  }
}
