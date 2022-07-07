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
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Color(0xfffaf88b),
              primary: Color(0xff388621),
              minimumSize: Size(88, 36),
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
          colorSchemeSeed: Color(0xff388621)),
    );
  }
}
