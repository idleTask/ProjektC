import 'package:flutter/material.dart';

class InterfaceData {
  //Variablen
  final Color _appBarTextColor = Colors.red[300];
  final Color _appBarBackgroundColor = Colors.blueGrey[800];
  final Color _containerColor = Colors.blueGrey[900];

  //Methoden
  Text coloredText(String text) {
    return Text(
      text,
      style: TextStyle(color: _appBarTextColor),
    );
  }

  Color getAppBarTextColor(){
    return _appBarTextColor;
  }

  Color getAppBarBackgroundColor(){
    return _appBarBackgroundColor;
  }

  Color getContainerColor(){
    return _containerColor;
  }
}