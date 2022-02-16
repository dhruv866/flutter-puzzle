import 'package:flutter/material.dart';
import 'package:puzzle_game/data.dart';

cacheLocalImage(BuildContext context) {
  for (var i = 0; i < gamesdata.length; i++) {
    precacheImage(
      Image.asset('assets/images/games/game${i}.png').image,
      context,
    );
  }
}
