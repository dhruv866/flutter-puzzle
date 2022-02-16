import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';
import 'package:puzzle_game/controllers/game_elements_state.dart';
import 'package:puzzle_game/controllers/game_state.dart';

puzzleblockMovement(double x, double y, BuildContext context, int index) {
  final state = context.read<GameElementsState>();
  double tile9x = state.elementposList['tile9']![0];
  double tile9y = state.elementposList['tile9']![1];

  if (x - 100 == tile9x || x + 100 == tile9x) {
    if (y == tile9y) {
      state.updateTileScale(index, 0.8);

      state.updateGame([x, y], 8);
      state.updateGame([tile9x, tile9y], index);
      context.read<GameState>().upadteTilesCount = 1;
    } else {
      print('NO');
    }
  } else if (y - 100 == tile9y || y + 100 == tile9y) {
    if (x == tile9x) {
      state.updateTileScale(index, 0.8);

      state.updateGame([x, y], 8);
      state.updateGame([tile9x, tile9y], index);
      context.read<GameState>().upadteTilesCount = 1;
    } else {
      print('NO');
    }
  } else {}
}
