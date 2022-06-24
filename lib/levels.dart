
class Level {
  final int ID;
  final int duration;
  final int numItems;
  final String backgroundPath;
  late bool timesPlay;
  late bool timesWin;

  Level({required this.ID, required this.duration, required this.numItems, this.backgroundPath = "assets/background.png"});

}