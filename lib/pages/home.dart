// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:jogo/player_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double score = Prog.getHighestScoreReached();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            child: Expanded(
              child: Text(
                'App Ecologico',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 55,
                  height: 1,
                  color: Colors.black,
                  inherit: false,
                ),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 250),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'High Score: $score',
                  style: TextStyle(
                    color: Colors.black,
                    inherit: false,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/game');
                    },
                    child: Text("Jogar")),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: Text('Settings'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
