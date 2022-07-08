import 'package:flutter/material.dart';
import 'package:jogo/levels.dart';
import 'package:jogo/pages/game.dart';


class GameOverPage extends StatefulWidget {
  final int id;
  final double score;
  final int duration;
  const GameOverPage({Key? key, required this.id, required this.score, required this.duration})
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
              child: Text("Pontuação: ${widget.score}", style: TextStyle(fontSize: 18))),


          ElevatedButton(
              onPressed: () {
                levels[widget.id]?.playLevel(context);

              },
              child: Text("JOGAR DE NOVO")),


          ElevatedButton(
              onPressed: () {
                Future.delayed(Duration.zero,(){
                  selectDifficulty(context, levels[widget.id]);
                });

              },
              child: Text("ESCOLHER DIFICULDADE")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/home');
              },
              child: Text("MENU")),
        ],
      ),
    );
  }
}

selectDifficulty(BuildContext context, Level? level) {
  Widget easy = TextButton(
    child: Text("Fácil"),
    onPressed: () => {
      level?.playLevel(context, mode: Mode.easy),

    },
  );

  Widget hard = TextButton(
    child: Text("Difícil"),
    onPressed: () =>
    {
      level?.playLevel(context, mode: Mode.hard),

    }
  );

  Widget normal = TextButton(
    child: Text("Normal"),
    onPressed: () => {
      level?.playLevel(context, mode: Mode.normal),
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
