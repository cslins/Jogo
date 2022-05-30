import 'package:flutter/material.dart';
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

  GamePage({Key? key, this.duration = 20}) : super(key: key);

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

  late List<Item> items;

  final List<RecycleBin> bins = [
    RecycleBin(
        name: 'Vidro', type: Type.glass, imagePath: "assets/LixeiraVidro.png"),
    RecycleBin(
        name: 'Plático',
        type: Type.plastic,
        imagePath: "assets/LixeiraPlastico.png"),
    RecycleBin(
        name: 'Orgânico',
        type: Type.organic,
        imagePath: "assets/LixeiraOrganico.png"),
    RecycleBin(
        name: 'Metal', type: Type.metal, imagePath: "assets/LixeiraMetal.png"),
    RecycleBin(
        name: 'Papel', type: Type.paper, imagePath: "assets/LixeiraPapel.png"),
  ];

  late bool gameOver;
  late double score;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      Item(
          name: 'Garrafa de Vidro',
          type: Type.glass,
          imagePath: "assets/GlassBottle.png",
          height: 50,
          width: 50),
      Item(
          name: 'Maçã',
          type: Type.organic,
          imagePath: "assets/Apple.png",
          width: 50,
          height: 50),
    ];
    items.shuffle();
    StartTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty || counter <= 0) gameOver = true;
    if (gameOver == false) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(clipBehavior: Clip.none, children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: items.map((item) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
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
                      child: Image(
                        image: AssetImage(item.imagePath),
                        height: item.height,
                        width: item.width,
                      ),
                    ),
                  );
                }).toList()),
          ),
          Positioned(left: 40, top: 30, child: Text("Tempo: $counter")),
          Positioned(right: 40, top: 30, child: Text("Pontuação: $score")),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: bins.map((bin) {
                  return DragTarget<Item>(onAccept: (data) {
                    if (bin.type == data.type) {
                      setState(() {
                        items.remove(data);
                        score += 10;
                        bin.accept = false;
                      });
                    } else {
                      setState(() {
                        items.remove(data);
                        score -= 10;
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
                            ? Image(
                                image: AssetImage(bin.imagePath),
                                height: 100,
                                width: 100,
                              )
                            : Image(
                                image: AssetImage(bin.imagePath),
                                height: 70,
                                width: 70,
                              ));
                  });
                }).toList()),
          )
        ]),
      );
    } else {
      StopTimer();
      Prog.setHighestScoreReached(score);
      return GameOverPage(
        score: score,
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
