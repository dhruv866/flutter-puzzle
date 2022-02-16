import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_game/controllers/game_state.dart';

import '../widgets.dart';

MainGame(Size size ) {
  return Consumer<GameState>(
    builder: (context, val, _) {
      return val.list.isNotEmpty ? Container(
        padding: EdgeInsets.all(20),
        width: size.width * 0.8,
        height: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            GameElement(val.list, 0),
            GameElement(val.list, 1),
            GameElement(val.list, 2),
            GameElement(val.list, 3),
            GameElement(val.list, 4),
            GameElement(val.list, 5),
            GameElement(val.list, 6),
            GameElement(val.list, 7),
            GameElement(val.list, 8),
          ],
        ),
      ) : CircularProgressIndicator();
    }
  );
}
