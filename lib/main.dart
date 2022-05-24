import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo/main.dart';
import 'package:jogo/items.dart';
import 'package:jogo/pages/home.dart';
import 'package:jogo/pages/game.dart';
import 'package:jogo/pages/settings.dart';
import 'package:jogo/player_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PlayerProgress()),
        ],
        child: Consumer<PlayerProgress>(
          builder: (context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomePage(),
              routes: {
                '/home': (context) => HomePage(),
                '/game': (context) => GamePage(),
                '/settings': (context) => Settings()
              },
            );
          },
        ));
  }
}
