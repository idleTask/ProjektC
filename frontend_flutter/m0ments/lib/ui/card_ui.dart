import 'package:flutter/material.dart';

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
    
    //return the build
    return sizedBox;
  }
}
