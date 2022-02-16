import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_game/controllers/home_state.dart';
import 'package:puzzle_game/data.dart';
import 'package:puzzle_game/functioning/load_game.dart';
import 'package:puzzle_game/ui/design.dart';
import 'package:puzzle_game/ui/widgets.dart';

import 'games/custom/custom_game.dart';
import 'games/select/select_game.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String? name;
  HomeScreen({Key? key, required this.name}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> firstTile;
  late Animation<double> secondTile;
  late Animation<double> thirdTile;
  late Animation op;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    firstTile = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.20, curve: Curves.easeOutBack),
      ),
    );
    secondTile = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.10, 0.30, curve: Curves.easeOutBack),
      ),
    );
    thirdTile = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.20, 0.40, curve: Curves.easeOutBack),
      ),
    );
    _controller.addListener(() {
      context.read<HomeState>().tile1val = firstTile.value;
      context.read<HomeState>().tile2val = secondTile.value;
      context.read<HomeState>().tile3val = thirdTile.value;
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int randomgameValue() {
    return Random().nextInt(gamesdata.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainscaffold,
        body: Column(
          children: [
            verticalSpace(20),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome ${widget.name}',
                  style: boldTextStyle(26).copyWith(
                    color: offwhite.withOpacity(0.950),
                  ),
                ),
              ),
            ),
            verticalSpace(100),
            Consumer<HomeState>(
              builder: (context, val, _) {
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(20),
                  children: [
                    Transform.scale(
                      scale: val.tile1,
                      child: HomeGameModelSelect(
                        context,
                        'Select Game',
                        SelectGame(),
                      ),
                    ),
                    Transform.scale(
                      scale: val.tile2,
                      child: HomeGameModelSelect(
                        context,
                        'Custom Game',
                        CustomGameImagePick(),
                      ),
                    ),
                    Transform.scale(
                      scale: val.tile3,
                      child: GestureDetector(
                        onTap: () {
                          load_game(context, 0, gamesdata[randomgameValue()]);
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
                              'Random Game',
                              style: boldTextStyle(26),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
