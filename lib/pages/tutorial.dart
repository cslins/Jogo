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
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialPage extends StatefulWidget {

  final String background = "assets/background.png";
  final numItems = 4;

  const TutorialPage({Key? key}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  late GameProperties properties;
  List <Item> items = [];
  bool visible = false;

  String instructions = "Clique e segure no item para ver a descrição. \n Isso pode ajudar a identificar a lixeira correta para colocá-lo";


  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    final _random = new Random();


    var element;

    for (var i = 0; i < widget.numItems; i++) {
      element = listItems[_random.nextInt(listItems.length)];
      items.add(Item(
          name: element.name,
          type: element.type,
          imagePath: element.imagePath,
          height: element.height,
          width: element.width,
          visibility: element.visibility));
    }
    properties = GameProperties(score: 0, items: items, gameOver: false, numItems: items.length);

  }



  @override
  Widget build(BuildContext context) {

    if (properties.numItems == 0) properties.gameOver = true;

      return Scaffold(
        body: Stack(clipBehavior: Clip.none, children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.background),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: properties.items.isNotEmpty? Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Draggable<Item>(
                    data: properties.items[0],
                    childWhenDragging: Container(
                      height: properties.items[0].height,
                      width: properties.items[0].width,
                    ),
                    feedback: Image(
                      image: AssetImage(properties.items[0].imagePath),
                      height: properties.items[0].height,
                      width: properties.items[0].width,
                    ),
                    child: properties.items[0].visibility
                        ? Tooltip(
                        message: properties.items[0].name,

                        child: Image(
                            image: AssetImage(properties.items[0].imagePath),
                            height: properties.items[0].height,
                            width: properties.items[0].width))
                        : Container(
                        height: properties.items[0].height,
                        width: properties.items[0].width),
                  )):Container(),
            ),
          ),

          Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                  child:Column(
                children: [Text("Coloque o item na lixeira correta"),
                  Visibility(
                      visible: visible,
                      child: Text(instructions,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),))],
              ))),


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
                          properties.numItems -= 1;
                          properties.items.remove(data);

                          visible = false;

                          bin.accept = false;

                          if (properties.items.isEmpty) {
                            endTutorialDialog(context);
                          }
                        });
                      } else {
                        setState(() {
                          bin.accept = false;
                          visible = true;
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

  Widget menu = TextButton(
    child: Text("Voltar ao menu"),
    onPressed: () {
      Navigator.of(context).popAndPushNamed('/home');
    },
  );

  //configura o AlertDialog
  AlertDialog endTutorialDialog = AlertDialog(

    title: Text("Muito Bem"),
    actions: [play, menu],
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
