import 'package:flutter/material.dart';

import '../models/ModelProvider.dart';

class UpdateInfo extends StatelessWidget {
  dynamic _name = '';
  Schools _school = Schools.School1;
  dynamic _class = '';
  dynamic age = '';
  Function onTapApprove;

  UpdateInfo({name: '', school: '', classname: '', age: ''}) {
    this._name = name;
    this._class = classname;
    this._school = school;
    this.age = age;
    this.onTapApprove;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: this._name,
              decoration: InputDecoration(labelText: 'Nafn barns'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Vinsamlegast fyllið út nafn';
                }
                return null;
              },
              onSaved: (value) => _name = value,
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: this._school.name,
                decoration: InputDecoration(labelText: 'Skóli'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Vinsamlegast fyllið út skóla';
                  }
                  return null;
                },
                onSaved: (value) => _school =
                    Schools.values.firstWhere((e) => e.toString() == value),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: this._class,
              decoration: InputDecoration(labelText: 'Bekkur'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Vinsamlegast fyllið út bekki';
                }
                return null;
              },
              onSaved: (value) => _class = value,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: this.age,
              decoration: InputDecoration(labelText: 'aldur barns'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Vinsamlegast fyllið út aldur barns';
                }
                return null;
              },
              onSaved: (value) => _class = value,
            ),
          )
        ],
      ),
    );
  }
}
