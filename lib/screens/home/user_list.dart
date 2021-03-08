import 'package:Lesaforrit/screens/home/read_tile.dart';
import 'package:flutter/material.dart';
import 'package:Lesaforrit/models/read.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Read>>(context) ?? [];
    List<Read> listi = [];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        users.sort((a, b) => b.totalpoints.compareTo(a.totalpoints));

        return ReadTile(read: users[index], rank: index + 1);
      },
    );
  }
}

/*
// Prenta út alla notendur
if (users != null && users is List<Read>) {
users.forEach((bla) {
print(bla.name);
print(bla.score);
print(bla.scoreTwo);
print(bla.scoreThree);
});
}
*/
