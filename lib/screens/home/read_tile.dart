import 'package:flutter/material.dart';
import 'package:Lesaforrit/models/read.dart';
import 'package:Lesaforrit/shared/constants.dart';
import 'package:random_color/random_color.dart';

class ReadTile extends StatelessWidget {
  final Read read;
  int rank;
  ReadTile({this.read, this.rank});

  String concat() {
    String zero = read.score;
    String one = read.scoreCaps;
    String two = read.scoreTwo;
    String twoLong = read.scoreTwoLong;
    String three = read.scoreThree;
    String threeLong = read.scoreThreeLong;
    double total = read.totalpoints;
    String concat = 'HEILDARSTIG: ' +
        total.toStringAsFixed(0) +
        '\n1) Hástafir: ' +
        one +
        ',           Lágstafir: ' +
        zero +
        '\n2) Stutt orð: ' +
        two +
        '          Löng orð: ' +
        twoLong +
        '\n3) Stuttar setn.: ' +
        three +
        '    Langar setn.: ' +
        threeLong;
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
