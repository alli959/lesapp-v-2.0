import 'package:flutter/material.dart';

class DialogDifficulty extends StatelessWidget {
  Function callback;
  Widget child;
  bool hasChosenDifficulty;
  DialogDifficulty(
      {Function callback, Widget child, bool hasChosenDifficulty}) {
    this.callback = callback;
    this.child = child;
    this.hasChosenDifficulty = hasChosenDifficulty;
  }
  @override
  Widget build(BuildContext context) {
    return this.hasChosenDifficulty
        ? child
        : AlertDialog(
            title: const Text('AlertDialog Title'),
            content: const Text('AlertDialog description'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    {Navigator.of(context).pop(), this.callback("easy")},
                child: const Text('Auðvellt'),
              ),
              TextButton(
                onPressed: () =>
                    {Navigator.of(context).pop(), this.callback("medium")},
                child: const Text('Miðlungs'),
              ),
            ],
          );
  }
}
