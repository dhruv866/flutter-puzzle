import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_game/controllers/game_state.dart';
import 'package:puzzle_game/ui/design.dart';
import 'package:puzzle_game/ui/game_screen/bootm_ui.dart';
import 'package:puzzle_game/ui/game_screen/main_game.dart';

// ignore: must_be_immutable
class CustomGame extends StatefulWidget {
  XFile pickedImage;
  CustomGame({Key? key, required this.pickedImage}) : super(key: key);

  @override
  _CustomGameState createState() => _CustomGameState();
}

class _CustomGameState extends State<CustomGame> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        child: Consumer<GameState>(
          builder: (context, val, _) {
            return val.hideOverlay
                ? ImagePixels(
                    imageProvider: Image.file(
                      File(widget.pickedImage.path),
                    ).image,
                    builder: (context, img) {
                      return Container(
                        padding: EdgeInsets.only(top: 40),
                        color: img.pixelColorAtAlignment!(Alignment.center)
                            .withOpacity(0.8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<GameState>().overlay = false;
                                context.read<GameState>().gamestart = false;
                                context.read<GameState>().upadteTilesCount = 0;
                                context.read<GameState>().stop_timer();

                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_left_rounded,
                                color: offwhite,
                                size: 40,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Card(
                                      elevation: 0,
                                      margin: EdgeInsets.all(10),
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            File(widget.pickedImage.path),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20, top: 5),
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(
                                    File(widget.pickedImage.path),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Container();
          },
        ),
        preferredSize: Size(double.infinity, kToolbarHeight),
      ),
      body: Stack(
        children: [
          GameScreen(
            src: widget.pickedImage.path,
          ),
          GameOverlay(context, widget.pickedImage.path, Colors.black),
        ],
      ),
    );
  }
}

Widget GameOverlay(BuildContext context, String src, Color color) {
  Size size = MediaQuery.of(context).size;
  return Consumer<GameState>(
    builder: (context, val, _) {
      return IgnorePointer(
        ignoring: val.hideOverlay ? true : false,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: val.hideOverlay ? 0 : 1,
          curve: Curves.fastOutSlowIn,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  val.overlay = true;
                },
                child: Container(
                  height: size.height,
                  width: size.width,
                  color: color,
                ),
              ),
              Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  height: size.width * 0.8,
                  width: size.width * 0.8,
                  child: Hero(
                    tag: 'tag',
                    child: Image.file(
                      File(src),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// ignore: must_be_immutable
class GameScreen extends StatefulWidget {
  String src;
  GameScreen({Key? key, required this.src}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ImagePixels(
      imageProvider: Image.file(
        File(widget.src),
      ).image,
      builder: (context, img) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                img.pixelColorAtAlignment!(Alignment.center),
                img.pixelColorAtAlignment!(Alignment.center).withOpacity(0.3),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalSpace(50),
                MainGame(size),
                verticalSpace(100),
                BottomUI(),
              ],
            ),
          ),
        );
      },
    );
  }
}
