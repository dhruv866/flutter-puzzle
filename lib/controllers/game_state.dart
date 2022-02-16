import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';
import 'package:puzzle_game/controllers/custom_game_state.dart';
import 'package:puzzle_game/screens/games/select/selectgame.dart';

class GameState extends ChangeNotifier {
  bool _hideOverlay = false;
  bool get hideOverlay => _hideOverlay;
  set overlay(bool val) {
    _hideOverlay = val;
    notifyListeners();
  }

  bool _startGame = false;
  bool get startGame => _startGame;
  set gamestart(bool val) {
    _startGame = val;
    notifyListeners();
  }

  int _tilesMoved = 0;
  int get tilesMoved => _tilesMoved;
  set upadteTilesCount(int val) {
    if (val == 0) {
      _tilesMoved = 0;
    } else {
      _tilesMoved += val;
    }
    notifyListeners();
  }

  //* TIMER CODE


  Duration _timerDuration = Duration();
  Duration get timerDuration => _timerDuration;

  Timer? timer;

  start_timer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      add_time();
    });
  }

  stop_timer(){
    if (timer != null) {
      timer!.cancel();
      _timerDuration = Duration();
    }
  }

  void add_time() {
    updateTimerDuration();
  }

  updateTimerDuration(){
    final seconds = _timerDuration.inSeconds + 1;
    _timerDuration = Duration(seconds: seconds);
    notifyListeners();
  }

  //* TIMER CODE FINISHED


  List<Image> _list = [];
  List<Image> get list => _list;

  //* Select Game Code
  updateSGImagelist(
      Future<List<Image>> val, BuildContext context, int index, String imgsrc) {
        Future.delayed(Duration(seconds: 2));
    val.then((listofimages) => a(listofimages, context, index, imgsrc));
  }

  a(List<Image> val, BuildContext context, int index, String imgsrc) {
    _list = val;
    _list.removeLast();
    _list.shuffle();
    notifyListeners();
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Game(
          index: index,
          src: imgsrc,
        ),
      ),
    );
  }

  // * Select Game Code Finished

  //* Custom Game Code

  updateCGImagelist(
      Future<List<Image>> val, BuildContext context, XFile file) {
    Future.delayed(Duration(seconds: 2));
    val.then((listofimages) => b(listofimages, context , file));
  }
  
  b(List<Image> val, BuildContext context, XFile file ) {
    _list = val;
    _list.removeLast();
    _list.shuffle();
    notifyListeners();
    context.read<CustomGameState>().updatesStatus(imagestate.done);
    
  }

  //* Custom Game Code Finished




}
