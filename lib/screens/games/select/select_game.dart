import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:puzzle_game/data.dart';
import 'package:puzzle_game/ui/design.dart';
import 'package:puzzle_game/ui/widgets.dart';

class SelectGame extends StatefulWidget {
  const SelectGame({Key? key}) : super(key: key);

  @override
  _SelectGameState createState() => _SelectGameState();
}

class _SelectGameState extends State<SelectGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainscaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: offwhite,
            size: 40,
          ),
        ),
        title: Text(
          'Select Game',
          style: boldTextStyle(24),
        ),
      ),
      body: AnimationLimiter(
        child: GridView.count(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(10),
          crossAxisCount: 2,
          children: List.generate(
            gamesdata.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 350),
                columnCount: 2,
                child: SlideAnimation(
                  curve: Curves.easeInOut,
                  verticalOffset: 200,
                  child: SelectGameWid(context, index),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
