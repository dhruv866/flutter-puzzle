import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier{
  double _tile1 = 0.0;
  double get tile1 => _tile1;

  set tile1val(double val){
    _tile1 = val;
    notifyListeners();
  }
  double _tile2 = 0.0;
  double get tile2 => _tile2;

  set tile2val(double val){
    _tile2 = val;
    notifyListeners();
  }
  double _tile3 = 0.0;
  double get tile3 => _tile3;

  set tile3val(double val){
    _tile3 = val;
    notifyListeners();
  }

}