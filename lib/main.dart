import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'items.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Item> items;
  late List<Item> items2;

  late bool gameOver;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    items = [
      Item(
          name: 'Garrafa de Vidro',
          type: Type.glass,
          imagePath: "assets/GlassBottle.png",
          height: 50,
          width: 50),
      Item(
          name: 'Maçã',
          type: Type.organic,
          imagePath: "assets/Apple.png",
          width: 50,
          height: 50),
    ];
    items.shuffle();

  }

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) gameOver = true;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items.map((item) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: Draggable<Item>(
              data: item,
              childWhenDragging: Container(
                height: item.height,
                width: item.width,
              ),
              feedback: Image(
                image: AssetImage(item.imagePath),
                height: item.height,
                width: item.width,
              ),
              child: Image(
                image: AssetImage(item.imagePath),
                height: item.height,
                width: item.width,
              ),
            ),
          );
        }).toList()),
      ),
    );
  }
}
