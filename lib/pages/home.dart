// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

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
      color: Colors.white,
      // alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Text(
              'Nome do Jogo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 55,
                height: 1,
                color: Colors.black,
                inherit: false,
              ),
            ),
          ),
          Container(
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
                          child: Text("Jogar")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          child: Text('Configurações')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/level_select');
                          },
                          child: Text('Fases'))
                    ]),
                Text(
                  'High Score: $score',
                  style: TextStyle(
                    color: Colors.black,
                    inherit: false,
                  ),
                ),
                Text(
                  'Partidas: $gamescont',
                  style: TextStyle(
                    color: Colors.black,
                    inherit: false,
                  ),
                ),
                Text(
                  'Moedas: $coins',
                  style: TextStyle(
                    color: Colors.black,
                    inherit: false,
                  ),
                ),
              ],
            ),
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
