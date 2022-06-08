import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:jogo/main.dart';
import 'package:jogo/items.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/game.dart';
import 'package:jogo/player_progress.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePage extends StatefulWidget {
  final int duration;

  const GamePage({Key? key, this.duration = 20}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late int counter = widget.duration;
  Timer? _timer;

  void StartTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          StopTimer();
        }
      });
    });
  }

  void StopTimer() {
    _timer?.cancel();
  }

  GameProperties properties =
      GameProperties(score: 0, items: [], gameOver: false, numItems: 7);

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    final _random = new Random();

    var element;

    for (var i = 0; i < properties.numItems; i++) {
      element = listItems[_random.nextInt(listItems.length)];
      properties.items.add(Item(
          name: element.name,
          type: element.type,
          imagePath: element.imagePath,
          height: element.height,
          width: element.width,
          visibility: element.visibility));
    }

    StartTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (properties.numItems <= 0 || counter <= 0) properties.gameOver = true;
    if (properties.gameOver == false) {
      return Scaffold(
        body: Stack(clipBehavior: Clip.none, children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: properties.items.map((item) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            properties.visibilityName = true;
                            properties.itemName = item.name;
                          });
                        },
                        onLongPressUp: () {
                          setState(() {
                            properties.visibilityName = false;
                            properties.itemName = '';
                          });
                        },
                        child: Draggable<Item>(
                          data: item,
                          childWhenDragging: Container(
                            height: item.height,
                            width: item.width,
                          ),
                          feedback: Image(
                            image: AssetImage(item.imagePath),
                            height: item.height,
                            width: item.width,
                          ),
                          child: item.visibility
                              ? Image(
                                  image: AssetImage(item.imagePath),
                                  height: item.height,
                                  width: item.width)
                              : Container(
                                  height: item.height, width: item.width),
                        )),
                  );
                }).toList()),
          ),
          Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Visibility(
                  visible: properties.visibilityName,
                  child: Text(properties.itemName),
                ),
              )),
          Positioned(left: 40, top: 30, child: Text("Tempo: $counter")),
          Positioned(
              right: 40,
              top: 30,
              child: Text("Pontuação: ${properties.score}")),
          Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: bins.map((bin) {
                    return DragTarget<Item>(onAccept: (data) {
                      if (bin.type == data.type) {
                        setState(() {
                          data.visibility = false;
                          properties.numItems -= 1;
                          properties.score += 10;
                          bin.accept = false;
                        });
                      } else {
                        setState(() {
                          data.visibility = false;
                          properties.numItems -= 1;
                          properties.score -= 10;
                          bin.accept = false;
                        });
                      }
                    }, onLeave: (data) {
                      setState(() {
                        bin.accept = false;
                      });
                    }, onWillAccept: (data) {
                      setState(() {
                        bin.accept = true;
                      });
                      return true;
                    }, builder: (context, candidateData, rejectedData) {
                      return Container(
                          child: bin.accept
                              ? Container(
                                  width: 100,
                                  child: Image(
                                    image: AssetImage(bin.imagePath),
                                    height: 100,
                                    width: 100,
                                  ))
                              : Container(
                                  width: 100,
                                  child: Image(
                                    image: AssetImage(bin.imagePath),
                                    height: 70,
                                    width: 70,
                                  )));
                    });
                  }).toList()))
        ]),
      );
    } else {
      StopTimer();
      Prog.setHighestScoreReached(properties.score);
      Prog.getaCoin();
      Prog.addplayedGames();
      return GameOverPage(
        score: properties.score,
        duration: widget.duration,
      );
    }
  }
}

class GameOverPage extends StatefulWidget {
  final double score;
  final int duration;
  const GameOverPage({Key? key, required this.score, required this.duration})
      : super(key: key);

  @override
  State<GameOverPage> createState() => _GameOverPageState();
}

class _GameOverPageState extends State<GameOverPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextButton(
              //! tornar em texto
              onPressed: () {},
              child: Text("Pontuação: ${widget.score}")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          GamePage(duration: widget.duration)),
                );
              },
              child: Text("JOGAR DE NOVO")),
          ElevatedButton(
              onPressed: () {
                SelectDifficulty(context);
              },
              child: Text("ESCOLHER DIFICULDADE")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/home');
              },
              child: Text("menu")),
        ],
      ),
    );
  }
}

SelectDifficulty(BuildContext context) {
  Widget easy = TextButton(
    child: Text("Fácil"),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GamePage(duration: 30)),
      );
    },
  );

  Widget hard = TextButton(
    child: Text("Difícil"),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GamePage(duration: 5)),
      );
    },
  );

  Widget normal = TextButton(
    child: Text("Normal"),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GamePage()),
      );
    },
  );

  //configura o AlertDialog
  AlertDialog difficulty = AlertDialog(
    title: Text("Escolha a dificulade"),
    actions: [easy, normal, hard],
  );

  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return difficulty;
    },
  );
}
