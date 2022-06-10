import 'package:flutter/material.dart';
import 'package:Lesaforrit/models/read.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:random_color/random_color.dart';

class ReadTile extends StatelessWidget {
  final Read read;
  int rank;
  ReadTile({this.read, this.rank});

  String concat() {
    double zero = read.lvlOneScore;
    double one = read.lvlOneCapsScore;
    double oneVoice = read.lvlOneVoiceScore;
    double two = read.lvlTwoEasyScore;
    double twoLong = read.lvlTwoMediumScore;
    double twoVoice = read.lvlTwoVoiceScore;
    double three = read.lvlThreeEasyScore;
    double threeLong = read.lvlThreeMediumScore;
    double threeVoice = read.lvlThreeVoiceScore;
    double total = read.totalpoints;
    String concat = 'HEILDARSTIG: ' +
        total.toStringAsFixed(0) +
        '\n1)\n   Hástafir:    ' +
        "$one" +
        ',\n   Lágstafir:   ' +
        "$read" +
        ',\n   Lesin orð:  ' +
        "$oneVoice" +
        '\n2)\n   Stutt orð:   ' +
        "$two" +
        ',\n   Löng orð:   ' +
        "$twoLong" +
        ',\n   Lesin orð:  ' +
        "$twoVoice" +
        '\n3)\n   Stuttar setningar:   ' +
        "$three" +
        ',\n   Langar setningar:   ' +
        "$threeLong" +
        ',\n   Lesnar setningar:   ' +
        "$threeVoice";
    return concat;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white,
            child: Image.asset('assets/images/stigataflaStjarna.png'),
          ),
          title: Text(rank.toString() + ': ' + read.name),
          subtitle: Text(concat()),
        ),
      ),
    );
  }
}
