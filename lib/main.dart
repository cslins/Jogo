import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo/main.dart';
import 'package:jogo/items.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/level_select.dart';
import 'package:jogo/pages/game.dart';
import 'package:jogo/pages/mapaBelem.dart';
import 'package:jogo/pages/settings.dart';
import 'package:jogo/pages/tutorial.dart';
import 'package:jogo/player_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        '/settings': (context) => Settings(),
        '/level_select': (context) => LevelSelect(),
        '/mapaBelem': (context) => MapaBelem(),
      },
    );
  }
}
