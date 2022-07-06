import 'package:flutter/material.dart';
import 'package:jogo/levels.dart';
import 'package:jogo/pages/game.dart';

class LevelSelect extends StatefulWidget {
  const LevelSelect({Key? key}) : super(key: key);

  @override
  State<LevelSelect> createState() => _LevelSelectState();
}

class _LevelSelectState extends State<LevelSelect> {

  List <Level> levels = [
    Level(id: 1, duration: 40, numItems: 5),
    Level(id: 2, duration: 35, numItems: 6),
    Level(id: 3, duration: 30, numItems: 7),
    Level(id: 4, duration: 25, numItems: 8),
    Level(id: 5, duration: 20, numItems: 8),
    Level(id: 6, duration: 15, numItems: 8),

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
                   Text("Fase ${level.id}",
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

