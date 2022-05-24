// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo/main.dart';
import 'package:jogo/items.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/game.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        // alignment: Alignment.center,
        child: Row(children: [
          Expanded(
                  child: Text(
            'App Ecologico',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Permanent Marker',
              fontSize: 55,
              height: 1,
              color: Colors.black,
              inherit: false,
            ),
          )),
          Container(
              //margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/game');
                },
                child: Text("Jogar")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tutorial');
                },
                child: Text('Tutorial'))
          ]))
        ]));
  }
}
