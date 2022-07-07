import 'package:flutter/material.dart';
import 'package:jogo/levels.dart';
import 'package:jogo/pages/game.dart';

class LevelSelect extends StatefulWidget {
  const LevelSelect({Key? key}) : super(key: key);

  @override
  State<LevelSelect> createState() => _LevelSelectState();
}

class _LevelSelectState extends State<LevelSelect> {



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

