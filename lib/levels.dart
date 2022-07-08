import 'package:flutter/material.dart';
import 'package:jogo/pages/game.dart';

class Level {
  final int id;
  late int duration;
  final int numItems;
  final String backgroundPath;
  late bool timesPlay;
  late bool timesWin;
  //Mode mode = Mode.normal;

  Level({required this.id, required this.duration, required this.numItems, this.backgroundPath = "assets/background.png"});

  playLevel(context,  {Mode mode = Mode.normal}){
    int counter = duration;

    if (mode == Mode.easy){
      counter = (duration * (1.5)).round();
    } else if (mode == Mode.hard){
      counter = (duration * (0.7)).round();
    }

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>
            GamePage(id: id,
              duration:counter,
              numItems: numItems,
              background: backgroundPath,
            )));
  }

}

enum Mode {easy, normal, hard}

final Map <int, Level> levels = {

  1: Level(id: 1, duration: 40, numItems: 5),
  2: Level(id: 2, duration: 35, numItems: 6),
  3: Level(id: 3, duration: 30, numItems: 7),
  4: Level(id: 4, duration: 25, numItems: 8),
  5: Level(id: 5, duration: 20, numItems: 8),
  6: Level(id: 6, duration: 15, numItems: 8),

};

