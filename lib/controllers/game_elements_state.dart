import 'package:flutter/material.dart';

class GameElementsState extends ChangeNotifier {
  Map<String, List<double>> _elementposList = {
    'tile1': [
      0,
      0,
    ],
    'tile2': [
      100,
      0,
    ],
    'tile3': [
      200,
      0,
    ],
    'tile4': [
      0,
      100,
    ],
    'tile5': [
      100,
      100,
    ],
    'tile6': [
      200,
      100,
    ],
    'tile7': [
      0,
      200,
    ],
    'tile8': [
      100,
      200,
    ],
    'tile9': [
      200,
      200,
    ],
  };
  Map<String, List<double>> get elementposList => _elementposList;

  List<double> _tileScale = List.generate(9, (index) => 1);
  List<double> get tileScale => _tileScale;

  updateTileScale(int index, double scale) {
    _tileScale[index] = scale;
    notifyListeners();
  }

  updateGame(
    List<double> pos,
    int index,
  ) {
    var comp = elementposList;
    comp.update('tile${index + 1}', (dynamic val) => pos);
    Future.delayed(Duration(milliseconds: 150), () {
      updateTileScale(index, 1);
    });
    notifyListeners();
  }

  shuffleGame() {
    _elementposList = {
      'tile1': [
        0,
        0,
      ],
      'tile2': [
        100,
        0,
      ],
      'tile3': [
        200,
        0,
      ],
      'tile4': [
        0,
        100,
      ],
      'tile5': [
        100,
        100,
      ],
      'tile6': [
        200,
        100,
      ],
      'tile7': [
        0,
        200,
      ],
      'tile8': [
        100,
        200,
      ],
      'tile9': [
        200,
        200,
      ],
    };

    notifyListeners();
  }
}
