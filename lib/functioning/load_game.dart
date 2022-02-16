import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/src/provider.dart';
import 'package:puzzle_game/controllers/game_state.dart';

import 'create_puzzle.dart';

load_game(BuildContext context, int index, String imageSrc) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return SimpleDialog(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        children: [
          SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              );
            },
          ),
        ],
      );
    },
  );

  final ByteData bytes = await rootBundle.load(imageSrc);
  final Uint8List list = bytes.buffer.asUint8List();
  await context
      .read<GameState>()
      .updateSGImagelist(splitImage(list), context, index, imageSrc);
}
