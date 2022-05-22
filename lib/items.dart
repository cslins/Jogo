import 'package:flutter/material.dart';


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



