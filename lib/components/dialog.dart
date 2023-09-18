import 'package:flutter/material.dart';

class DialogDifficulty extends StatelessWidget {
  final Function callback;
  final Widget child;
  final bool hasChosenDifficulty;

  DialogDifficulty({
    required this.callback,
    required this.child,
    required this.hasChosenDifficulty,
  });

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
