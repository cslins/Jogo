// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: prefer_conditional_assignment

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

abstract class PlayerProgressPersistence {
  Future<int> getHighestLevelReached();
  Future<int> getHighestScoreReached();

  Future<void> saveHighestLevelReached(int level);
  Future<void> saveHighestScoreReached(int score);
}

class LocalStoragePlayerProgressPersistence extends PlayerProgressPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  @override
  Future<int> getHighestLevelReached() async {
    final prefs = await instanceFuture;
    return prefs.getInt('highestLevelReached') ?? 0;
  }

  @override
  Future<void> saveHighestLevelReached(int level) async {
    final prefs = await instanceFuture;
    await prefs.setInt('highestLevelReached', level);
  }

  @override
  Future<int> getHighestScoreReached() async {
    final prefs = await instanceFuture;
    return prefs.getInt('highestScoreReached') ?? 0;
  }

  @override
  Future<void> saveHighestScoreReached(int score) async {
    final prefs = await instanceFuture;
    await prefs.setInt('highestScoreReached', score);
  }
}

class PlayerProgress extends ChangeNotifier {
  int _highestLevelReached = 0;
  double _highestScoreReached = 0;

  SharedPreferences? _preferences;

  int get highestLevelReached => _highestLevelReached;
  double get highestScoreReached => _highestScoreReached;

  PlayerProgress() {
    _loadprefs();
  }

  _intializer() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  _loadprefs() async {
    await _intializer();
    _highestLevelReached = _preferences?.getInt('level') ?? 0;
    _highestScoreReached = _preferences?.getDouble('score') ?? 0;
    notifyListeners();
  }

  _savePrefs() async {
    await _intializer();
    _preferences?.setInt('level', _highestLevelReached);
    _preferences?.setDouble('score', _highestScoreReached);
    notifyListeners();
  }

  void setLevelReached(int level) {
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      _savePrefs();
      notifyListeners();
    }
  }

  void setScoreReached(double score) {
    if (score > _highestScoreReached) {
      _highestScoreReached = score;
      _savePrefs();
      notifyListeners();
    }
  }

  Future<double> getHighestScoreReached() async {
    await _intializer();
    return _preferences?.getDouble('score') ?? 0;
  }

  Future<int> getHighestLevelReached() async {
    await _intializer();
    return _preferences?.getInt('level') ?? 0;
  }
}



/// Encapsulates the player's progress.
// class PlayerProgress extends ChangeNotifier {
//   //!static const maxHighestScoresPerPlayer = 10;

//   final PlayerProgressPersistence _store;

//   int _highestLevelReached = 0;
//   int _highestScoreReached = 0;

//   /// Creates an instance of [PlayerProgress] backed by an injected
//   /// persistence [store].
//   PlayerProgress(PlayerProgressPersistence store) : _store = store;

//   /// The highest level that the player has reached so far.
//   int get highestLevelReached => _highestLevelReached;
//   int get highestScoreReached => _highestScoreReached;

//   /// Fetches the latest data from the backing persistence store.
//   Future<void> getLatestFromStore() async {
//     final level = await _store.getHighestLevelReached();
//     if (level > _highestLevelReached) {
//       _highestLevelReached = level;
//       notifyListeners();
//     } else if (level < _highestLevelReached) {
//       await _store.saveHighestLevelReached(_highestLevelReached);
//     }
//   }

//   /// Resets the player's progress so it's like if they just started
//   /// playing the game for the first time.
//   void reset() {
//     _highestLevelReached = 0;
//     notifyListeners();
//     _store.saveHighestLevelReached(_highestLevelReached);
//   }

//   /// Registers [level] as reached.
//   ///
//   /// If this is higher than [highestLevelReached], it will update that
//   /// value and save it to the injected persistence store.
//   void setLevelReached(int level) {
//     if (level > _highestLevelReached) {
//       _highestLevelReached = level;
//       notifyListeners();

//       unawaited(_store.saveHighestLevelReached(level));
//     }
//   }
// }
