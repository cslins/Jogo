import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo/main.dart';
import 'package:jogo/levels.dart';
import 'package:jogo/items.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/level_select.dart';
import 'package:jogo/pages/game.dart';
import 'package:jogo/pages/settings.dart';
import 'package:jogo/pages/tutorial.dart';
import 'package:jogo/player_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LevelSelect extends StatefulWidget {
  const LevelSelect({Key? key}) : super(key: key);

  @override
  State<LevelSelect> createState() => _LevelSelectState();
}

class _LevelSelectState extends State<LevelSelect> {

  List <Level> levels = [
    Level(ID: 1, duration: 40, numItems: 5),
    Level(ID: 2, duration: 35, numItems: 6),
    Level(ID: 3, duration: 30, numItems: 7),
    Level(ID: 4, duration: 25, numItems: 8),
    Level(ID: 5, duration: 20, numItems: 8),
    Level(ID: 6, duration: 15, numItems: 8),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: levels.map((level) {
          return OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        GamePage(duration:level.duration,
                          numItems: level.numItems,
                          background: level.backgroundPath,
                        )));
              },
              child: Row(
                children: <Widget> [
                   Text("Fase ${level.ID}",
                      style: TextStyle(fontSize: 40)), // <-- Text
                  Spacer(),
                  Icon(
// <-- Icon
                    Icons.arrow_forward_ios,
                    size: 40.0,
                  ),
                ],
              ));


    }).toList(),
      ),
    );
  }
}

