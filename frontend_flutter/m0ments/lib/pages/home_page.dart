import 'package:flutter/material.dart';
import 'package:m0ments/ui/home_page_ui.dart';

class HomePage extends StatefulWidget {
  final String title = "m0ments";
  const HomePage();

  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomePageUi(title: widget.title,);
  }
}
