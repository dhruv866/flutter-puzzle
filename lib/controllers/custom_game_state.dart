import 'package:flutter/material.dart';

enum imagestate { select, loading, done }


class CustomGameState extends ChangeNotifier{

  var _status = imagestate.select;
  get status => _status;

  updatesStatus(val){
    _status = val;
    notifyListeners();
  }
  

}