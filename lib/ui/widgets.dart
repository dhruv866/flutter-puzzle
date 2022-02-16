import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_game/controllers/game_elements_state.dart';
import 'package:puzzle_game/controllers/game_state.dart';
import 'package:puzzle_game/data.dart';
import 'package:puzzle_game/functioning/load_game.dart';
import 'package:puzzle_game/functioning/puzzle_movement.dart';
import 'package:puzzle_game/ui/design.dart';
import 'animations.dart';

Widget HomeGameModelSelect(BuildContext context, String text, Widget screen) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        navslideAnimation(
          screen,
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.all(20).copyWith(bottom: 50),
      width: MediaQuery.of(context).size.width * 0.7,
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.50),
              offset: Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 3),
        ],
        color: mainblue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: boldTextStyle(26),
        ),
      ),
    ),
  );
}

Widget SelectGameWid(BuildContext context, int index) {
  return GestureDetector(
    onTap: () {
      load_game(context, index, gamesdata[index]);
    },
    child: Hero(
      tag: 'tag${index}',
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(5),
        height: 100,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [containerboxshadow().scale(0.4)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            gamesdata[index],
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

Widget GameElement(List<Image> list, int index) {
  return Consumer<GameElementsState>(
    builder: (context, val, _) {
      return AnimatedPositioned(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
        left: val.elementposList['tile${index + 1}']![0],
        top: val.elementposList['tile${index + 1}']![1],
        child: index != 8
            ? GestureDetector(
                onTap: () {
                  if (context.read<GameState>().startGame) {
                    puzzleblockMovement(
                        val.elementposList['tile${index + 1}']![0],
                        val.elementposList['tile${index + 1}']![1],
                        context,
                        index);
                  }
                },
                child: AnimatedScale(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 300),
                  scale: val.tileScale[index],
                  child: Container(
                    height: 90,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(image: list[index].image),
                    ),
                  ),
                ),
              )
            : Container(),
      );
    },
  );
}
