import 'package:flutter/material.dart';
import 'package:jogo/pages/game.dart';


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
                selectDifficulty(context);
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

selectDifficulty(BuildContext context) {
  Widget easy = TextButton(
    child: Text("Fácil"),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GamePage(duration: 40)),
      );
    },
  );

  Widget hard = TextButton(
    child: Text("Difícil"),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GamePage(duration: 15)),
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
