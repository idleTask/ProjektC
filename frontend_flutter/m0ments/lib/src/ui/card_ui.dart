import 'package:flutter/material.dart';
import 'package:m0ments/src/ui/detailedPage_ui.dart';

class CardUi extends StatelessWidget {
  final String img;

  const CardUi({
    this.img,
  });

  Widget build(BuildContext context) {
    //build the card
    var card = new Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        img,
        fit: BoxFit.fill,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );

    //build the sized box with the card inside
    var sizedBox = new Container(
      child: SizedBox(
        child: card,
      ),
    );

    //build the sized box wrapped with a gesturedetector
    var gestureDetector = new GestureDetector(
      onTapUp: (TapUpDetails) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailedPage()),
        );
      },
      child: sizedBox,
    );

    //return the build
    return gestureDetector;
  }
}
