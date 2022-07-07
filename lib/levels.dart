
class Level {
  final int id;
  final int duration;
  final int numItems;
  final String backgroundPath;
  late bool timesPlay;
  late bool timesWin;

  Level({required this.id, required this.duration, required this.numItems, this.backgroundPath = "assets/background.png"});

}


final List <Level> levels = [
  Level(id: 1, duration: 40, numItems: 5),
  Level(id: 2, duration: 35, numItems: 6),
  Level(id: 3, duration: 30, numItems: 7),
  Level(id: 4, duration: 25, numItems: 8),
  Level(id: 5, duration: 20, numItems: 8),
  Level(id: 6, duration: 15, numItems: 8),

];