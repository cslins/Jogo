import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo/main.dart';
import 'package:jogo/items.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/game.dart';


enum Type{
  organic,
  glass,
  plastic,
  metal,
  paper

}

class Item{
  String name;
  Type type;
  String imagePath;
  double height;
  double width;

  Item({required this.name,
    required this.type,
    required this.imagePath,
    required this.height,
    required this.width});

}


class RecycleBin{
  String name;
  Type type;
  String imagePath;
  bool accept;

  RecycleBin({required this.name, 
    required this.type, 
    required this.imagePath, 
    this.accept = false});

}

