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
  
  final List<RecycleBin> bins = [
      RecycleBin(name: 'Vidro', type: Type.glass, imagePath: "assets/LixeiraVidro.png"),
      RecycleBin(name: 'Plático', type: Type.plastic, imagePath: "assets/LixeiraPlastico.png"),
      RecycleBin(name: 'Orgânico', type: Type.organic, imagePath: "assets/LixeiraOrganico.png"),
      RecycleBin(name: 'Metal', type: Type.metal, imagePath: "assets/LixeiraMetal.png"),
      RecycleBin(name: 'Papel', type: Type.paper, imagePath: "assets/LixeiraPapel.png"),

    ];

  late bool gameOver;
  late double score;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    score = 0;
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
    if (items.isEmpty) gameOver = true;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [Row(
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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: bins.map((bin) {
          return DragTarget<Item>(
              onAccept: (data){
                if(bin.type == data.type){
                  setState(() {
                    items.remove(data);
                    score+=10;
                    bin.accept = false;
                  });
                } else {
                  setState(() {
                    score-=10;
                    bin.accept = false;
                  });
                }              
              },
              onLeave: (data){
                setState(() {
                  bin.accept=false;
                  });
              },
              onWillAccept: (data){
                setState(() {
                  bin.accept=true;
                  });
                  return true;
                  },

              builder: (context, candidateData, rejectedData) {
                return Container(
                  child: bin.accept?Image(
                  image: AssetImage(bin.imagePath),
                  height: 70,
                  width: 70,):
                  Image(
                  image: AssetImage(bin.imagePath),
                  height: 50,
                  width: 50,)
                );
                }
            
            );
          
        }).toList()),
        
        ]
        ),
      );
  }
}
