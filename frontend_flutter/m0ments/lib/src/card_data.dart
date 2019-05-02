import 'package:flutter/material.dart';
import 'package:m0ments/ui/card_ui.dart';

class CardData extends StatefulWidget {
  CardDataState createState() => CardDataState();

  final String descr;
  final img;
  final int votes;
  final String user;

  const CardData({
    this.descr,
    this.img,
    this.votes,
    this.user,
  });
}

class CardDataState extends State<CardData> {
  Widget build(BuildContext context) {
    return CardUi(img: "lib/res/images/surprised_pikatchu.png");
  }
}
