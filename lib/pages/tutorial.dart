import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo/main.dart';
import 'package:jogo/items.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/game.dart';
import 'dart:async';

import 'package:jogo/pages/tutorial.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  late Item item;

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

  @override
  void initState() {
    super.initState();
    initTutorial();
  }

  initTutorial() {
    gameOver = false;

    item = Item(
        name: 'Garrafa de Vidro',
        type: Type.glass,
        imagePath: "assets/GlassBottle.png",
        height: 50,
        width: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(clipBehavior: Clip.none, children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(),
        ),
        Center(
          child: Container(
            alignment: Alignment.center,
            height: item.height,
            width: item.width,
            child: gameOver
                ? Container()
                : Draggable<Item>(
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
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: TextButton(
            child: Text("Coloque a garrafa na lixeira correta"),
            onPressed: () {},
          ),
        ),
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
                      endTutorialDialog(context);
                      gameOver = true;
                      bin.accept = false;
                    });
                  } else {
                    setState(() {
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
  }
}

endTutorialDialog(BuildContext context) {
  Widget play = TextButton(
    child: Text("Jogar"),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GamePage()),
      );
    },
  );

  //configura o AlertDialog
  AlertDialog endTutorialDialog = AlertDialog(

    title: Text("Muito Bem"),
    actions: [play],
  );

  //exibe o diálogo
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return endTutorialDialog;
    },
  );
}
