import 'package:flutter/material.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/pages/detailedPage.dart';
import 'package:bloc/bloc.dart';

class CardUi extends StatelessWidget {
  final M0mentCardBloc bloc;
  final String img;

  const CardUi({
    this.img,
    this.bloc,
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
      onTapUp: (tapUpDetails) {
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
