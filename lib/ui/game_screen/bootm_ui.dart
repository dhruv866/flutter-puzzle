import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_game/controllers/game_elements_state.dart';
import 'package:puzzle_game/controllers/game_state.dart';

import '../design.dart';

Widget BottomUI() {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return Consumer<GameState>(
    builder: (context, val, _) {
      final hour = twoDigits(val.timerDuration.inHours);
      final minutes = twoDigits(val.timerDuration.inMinutes.remainder(60));
      final seconds = twoDigits(val.timerDuration.inSeconds.remainder(60));
      return Column(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Tiles Moved',
                        style: regularTextStyle(20),
                      ),
                      verticalSpace(10),
                      Text(
                        '${val.tilesMoved}',
                        style: boldTextStyle(20),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 70,
                  child: VerticalDivider(
                    color: offwhite.withOpacity(0.6),
                    thickness: 3,
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          'Time',
                          style: regularTextStyle(20),
                        ),
                      ),
                      verticalSpace(10),
                      SizedBox(
                        width: 120,
                        child: Container(
                          child: Text(
                            '${hour}:${minutes}:${seconds}',
                            style: boldTextStyle(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(40),
          AnimatedSwitcher(
            switchInCurve: Curves.easeInOutExpo,
            switchOutCurve: Curves.easeInOutExpo,
            duration: Duration(milliseconds: 200),
            child: !val.startGame
                ? ElevatedButton(
                    key: Key('startbtn'),
                    onPressed: () {
                      val.gamestart = true;
                      val.start_timer();
                    },
                    child: Text(
                      'Start',
                      style: boldTextStyle(22),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0.3)),
                      elevation: MaterialStateProperty.all(1),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 13, horizontal: 20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                    ),
                  )
                : ElevatedButton(
                    key: Key('restartbtn'),
                    onPressed: () {
                      val.gamestart = false;
                      val.stop_timer();
                      val.upadteTilesCount = 0;
                      context.read<GameElementsState>().shuffleGame();
                    },
                    child: Text(
                      'Restart',
                      style: boldTextStyle(22),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0.5)),
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 13, horizontal: 20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
          ),
          verticalSpace(40),
        ],
      );
    },
  );
}
