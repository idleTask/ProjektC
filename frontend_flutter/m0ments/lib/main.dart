import 'package:flutter/material.dart';
import 'package:m0ments/src/pages/homePage.dart';

void main() => runApp(M0mentsApp());

class M0mentsApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colorspace',
      home: HomePage(),
    );
  }
}
