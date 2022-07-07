// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jogo/player_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double score = Prog.getHighestScoreReached();
  int gamescont = Prog.getGamesCont();
  int coins = Prog.getCoinsCont();

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "assets/city-scene-from-the-park-view-free-vector.png"),
          fit: BoxFit.cover,
        ),
      ), // alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Text(
                  'EcoApp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 55,
                    height: 1,
                    color: Color(0xff3B1C0C),
                    inherit: false,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/game');
                              },
                              child: Text("Jogar", style: TextStyle(fontSize: 20),)),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/tutorial');
                              },
                              child: Text("Tutorial", style: TextStyle(fontSize: 20))),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/settings');
                              },
                              child: Text('Configurações', style: TextStyle(fontSize: 20))),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/level_select');
                              },
                              child: Text('Fases', style: TextStyle(fontSize: 20)))
                        ]),
                    Text(
                      'High Score: $score',
                      style: TextStyle(
                        color: Colors.black,
                        inherit: false,
                        fontSize: 18
                      ),
                    ),
                    Text(
                      'Partidas: $gamescont',
                      style: TextStyle(
                        color: Colors.black,
                        inherit: false,
                          fontSize: 18
                      ),
                    ),
                    Text(
                      'Moedas: $coins',
                      style: TextStyle(
                        color: Colors.black,
                        inherit: false,
                          fontSize: 18
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          TextButton(
            child: Icon(
              Icons.where_to_vote,
              color: Color.fromARGB(255, 31, 49, 150),
              size: 50.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/mapaBelem');
            },
          ),
        ],
      ),
    );
  }
}
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       // alignment: Alignment.center,
//       child: Row(
//         children: [
//           Container(
//             child: Expanded(
//               child: Text(
//                 'App Ecologico',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: 'Permanent Marker',
//                   fontSize: 55,
//                   height: 1,
//                   color: Colors.black,
//                   inherit: false,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             constraints: BoxConstraints(minWidth: 250),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Consumer<PlayerProgress>(
//                   builder: (context, value, child) {
//                     double score = value.highestScoreReached;
//                     return Text(
//                       'High Score: ${score}',
//                       style: TextStyle(
//                         color: Colors.black,
//                         inherit: false,
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/game');
//                     },
//                     child: Text("Jogar")),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/settings');
//                     },
//                     child: Text('Settings'))
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
