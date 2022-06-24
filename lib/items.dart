import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo/main.dart';
import 'package:jogo/items.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/game.dart';
import 'package:jogo/pages/level_select.dart';

enum Type { organic, glass, plastic, metal, paper }

final List<Item> listItems = [
  Item(name: 'Garrafa de Vidro', type: Type.glass, imagePath: "assets/GlassBottle.png", height: 50, width: 50, visibility: true),
  Item(name: 'Caneca Quebrada', type: Type.glass, imagePath: "assets/CrackedMug.png", width: 50, height: 50, visibility: true),


  Item(name: 'Maçã', type: Type.organic, imagePath: "assets/Apple.png", width: 50, height: 50, visibility: true),
  Item(name: 'Casca de Banana', type: Type.organic, imagePath: "assets/BananaPeel.png", width: 70, height: 70, visibility: true),


  Item(name: 'Papel Amassado', type: Type.paper, imagePath: "assets/Paper.png", width: 40, height: 40, visibility: true),
  Item(name: 'Caixa de Papelão', type: Type.paper, imagePath: "assets/PaperBox.png", width: 90, height: 90, visibility: true),



  Item(name: 'Sacola de Plástico', type: Type.plastic, imagePath: "assets/PlasticBag.png", width: 80, height: 80, visibility: true),
  Item(name: 'Garrafa de Plástico', type: Type.plastic, imagePath: "assets/PlasticBottle.png", width: 70, height: 70, visibility: true),

  Item(name: 'Lata', type: Type.metal, imagePath: "assets/SmallCan.png", width: 50, height: 50, visibility: true),
];

final List<RecycleBin> bins = [
  RecycleBin(name: 'Vidro', type: Type.glass, imagePath: "assets/LixeiraVidro.png"),
  RecycleBin(name: 'Plático', type: Type.plastic, imagePath: "assets/LixeiraPlastico.png"),
  RecycleBin(name: 'Orgânico', type: Type.organic, imagePath: "assets/LixeiraOrganico.png"),
  RecycleBin(name: 'Metal', type: Type.metal, imagePath: "assets/LixeiraMetal.png"),
  RecycleBin(name: 'Papel', type: Type.paper, imagePath: "assets/LixeiraPapel.png"),
];

class Item {
  final String name;
  final Type type;
  final String imagePath;
  final double height;
  final double width;
  bool visibility;

  Item({required this.name, required this.type, required this.imagePath, required this.height, required this.width, required this.visibility});
}

class RecycleBin {
  final String name;
  final Type type;
  final String imagePath;
  bool accept;

  RecycleBin({required this.name, required this.type, required this.imagePath, this.accept = false});
}

class GameProperties {
  double score;
  List<Item> items;
  bool gameOver;
  int numItems;

  String itemName = '';
  bool visibilityName = false;

  GameProperties({this.score = 0, required this.items, this.gameOver = false, required this.numItems});
}
/*

class Bins extends StatefulWidget {
  late GameProperties properties;
  Bins({Key? key, required this.properties}) : super(key: key);

  @override
  State<Bins> createState() => _BinsState();
}

class _BinsState extends State<Bins> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: bins.map((bin) {
          return DragTarget<Item>(onAccept: (data) {
            if (bin.type == data.type) {
              setState(() {
                data.visibility = false;
                widget.properties.numItems -= 1;
                widget.properties.score += 10;
                bin.accept = false;
              });
            } else {
              setState(() {
                data.visibility = false;
                widget.properties.numItems -= 1;
                widget.properties.score -= 10;
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
        }).toList());
  }
}



 */
