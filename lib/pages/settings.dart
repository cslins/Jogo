import 'package:flutter/material.dart';
import 'package:jogo/player_progress.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              await Prog.reset();
            },
            child: const Text('resetar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/home');
            },
            child: Text("menu"),
          ),
        ],
      ),
    );
  }
}
