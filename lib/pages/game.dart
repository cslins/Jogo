import 'package:flutter/material.dart';
import 'dart:math';
import 'package:jogo/items.dart';
import 'package:jogo/levels.dart';
import 'package:jogo/pages/game_over.dart';
import 'package:jogo/player_progress.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  final int id;
  final int duration;
  final int numItems;
  final String background;

  const GamePage({Key? key, required this.id, this.duration = 30, this.numItems = 6,
    this.background = "assets/background.png"}) : super(key: key);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  late int counter = widget.duration;
  late GameProperties properties;
  List <Item> items = [];
  Timer? _timer;

  bool show = false;
  bool visible = false;
  Color color = Colors.white;
  int point = 0;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }


  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    final random = Random();


    Item element;

    for (var i = 0; i < widget.numItems; i++) {
      element = listItems[random.nextInt(listItems.length)];
      items.add(Item(
          name: element.name,
          type: element.type,
          imagePath: element.imagePath,
          height: element.height,
          width: element.width,
          visibility: element.visibility));
    }
    properties = GameProperties(score: 0, items: items, gameOver: false, numItems: items.length);
    startTimer();
  }



  @override
  Widget build(BuildContext context) {

    if (properties.numItems == 0 || counter <= 0) properties.gameOver = true;
    if (properties.gameOver == false) {
      return Scaffold(
        body: Stack(clipBehavior: Clip.none, children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.background),
                fit: BoxFit.cover,
              ),
            ),
            child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.center,

                children: properties.items.map((item) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Draggable<Item>(
                          data: item,
                          childWhenDragging: SizedBox(
                            height: item.height,
                            width: item.width,
                          ),
                          feedback: Image(
                            image: AssetImage(item.imagePath),
                            height: item.height,
                            width: item.width,
                          ),
                          child: item.visibility
                              ? Tooltip(
                              message: item.name,

                              child:Image(
                                  image: AssetImage(item.imagePath),
                                  height: item.height,
                                  width: item.width))
                              : SizedBox(
                                  height: item.height, width: item.width),
                        ),
                  );
                }).toList()),
          ),


          // Contagem do tempo
          Positioned(left: 40, top: 30,
              child: Text("Tempo: $counter",
              style: TextStyle(fontSize: 20))),


          // Animação da pontuação
          AnimatedPositioned(
              right: 40,
              top: show?60: 30,
              curve: Curves.fastOutSlowIn,
              onEnd: (){
                visible = false;},
              duration: Duration(milliseconds: 1000),

              child: AnimatedOpacity(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                opacity: visible? 1: 0,
                onEnd: () {
                  show = false;
                },

                child: Text("$point", style: TextStyle(color: color, fontSize: 25),),

              )),

          // Pontuação
          Positioned(
              right: 40,
              top: 30,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                padding: EdgeInsets.all(2),

                child:Text("Pontuação: ${properties.score}",
                  style: TextStyle(color: Colors.black, fontSize: 20),),)),



          // Lista de lixeiras
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
                          point = 10;
                          properties.score += point;
                          visible = true;

                          show = true;
                          color = Colors.green;
                          bin.accept = false;
                        });
                      } else {
                        setState(() {
                          data.visibility = false;
                          properties.numItems -= 1;

                          visible = true;

                          point = -10;
                          properties.score += point;
                          show = true;
                          color = Colors.red;

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
                              ? SizedBox(
                                  width: 100,
                                  child: Image(
                                    image: AssetImage(bin.imagePath),
                                    height: 100,
                                    width: 100,
                                  ))
                              : SizedBox(
                                  width: 100,
                                  child: Image(
                                    image: AssetImage(bin.imagePath),
                                    height: 90,
                                    width: 90,
                                  )));
                    });
                  }).toList()))
        ]),
      );
    } else {
      stopTimer();
      Prog.setHighestScoreReached(properties.score);
      Prog.getaCoin();
      Prog.addplayedGames();
      return GameOverPage(
        id: widget.id,
        score: properties.score,
        duration: widget.duration,
      );
    }
  }
}
