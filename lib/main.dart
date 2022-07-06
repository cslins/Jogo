import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/level_select.dart';
import 'package:jogo/pages/game.dart';
import 'package:jogo/pages/mapa_belem.dart';
import 'package:jogo/pages/settings.dart';
import 'package:jogo/pages/tutorial.dart';
import 'package:jogo/player_progress.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prog.init();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then(
    (_) {
      runApp(MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/game': (context) => GamePage(),
        '/tutorial': (context) => TutorialPage(),
        '/settings': (context) => Settings(),
        '/level_select': (context) => LevelSelect(),
        '/mapaBelem': (context) => MapaBelem(),
      },
    );
  }
}
