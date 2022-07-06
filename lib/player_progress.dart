import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Prog {
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static double getHighestScoreReached() {
    return _preferences.getDouble('highestScoreReached') ?? 0.0;
  }

  static Future setHighestScoreReached(double score) async {
    double oldscore = _preferences.getDouble('highestScoreReached') ?? 0.0;

    if (score > oldscore) {
      await _preferences.setDouble('highestScoreReached', score);
    }
  }

  static Future reset() async {
    await _preferences.setDouble('highestScoreReached', 0.0);
    await _preferences.setInt('Games', 0);
    await _preferences.setInt('Coins', 0);
  }

  static Future addplayedGames() async {
    int contGames = _preferences.getInt('Games') ?? 0;
    await _preferences.setInt('Games', (contGames + 1));
  }

  static int getGamesCont() {
    return _preferences.getInt('Games') ?? 0;
  }

  static int getCoinsCont() {
    return _preferences.getInt('Coins') ?? 0;
  }

  static Future getaCoin() async {
    int contGames = _preferences.getInt('Games') ?? 0;
    if (contGames <= 0) {
      await _preferences.setInt('Coins', 1);
    }
  }
}
