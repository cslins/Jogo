import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo/main.dart';
import 'package:jogo/items.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/game.dart';

enum Type { organic, glass, plastic, metal, paper }

final List<Item> listItems = [
  Item(name: 'Garrafa de Vidro', type: Type.glass, imagePath: "assets/GlassBottle.png", height: 50, width: 50, visibility: true),
  Item(name: 'Caneca Quebrada', type: Type.glass, imagePath: "assets/CrackedMug.png", width: 50, height: 50, visibility: true),


  Item(name: 'Maçã', type: Type.organic, imagePath: "assets/Apple.png", width: 50, height: 50, visibility: true),
  Item(name: 'Casca de Banana', type: Type.organic, imagePath: "assets/BananaPeel.png", width: 50, height: 50, visibility: true),


  Item(name: 'Papel Amassado', type: Type.paper, imagePath: "assets/Paper.png", width: 50, height: 50, visibility: true),
  Item(name: 'Caixa de Papelão', type: Type.paper, imagePath: "assets/PaperBox.png", width: 50, height: 50, visibility: true),



  Item(name: 'Sacola de Plástico', type: Type.plastic, imagePath: "assets/PlasticBag.png", width: 50, height: 50, visibility: true),
  Item(name: 'Garrafa de Plástico', type: Type.plastic, imagePath: "assets/PlasticBottle.png", width: 50, height: 50, visibility: true),

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
  String name;
  Type type;
  String imagePath;
  double height;
  double width;
  bool visibility;

  Item({required this.name, required this.type, required this.imagePath, required this.height, required this.width, required this.visibility});
}

class RecycleBin {
  String name;
  Type type;
  String imagePath;
  bool accept;

  RecycleBin({required this.name, required this.type, required this.imagePath, this.accept = false});
}
