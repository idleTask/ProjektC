import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/cardList_bloc.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/pages/detailedPage.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';
import 'package:bloc/bloc.dart';

class CardUi extends StatelessWidget {
  final CardListBloc clBloc;
  final M0mentCard m0mentCard;

  const CardUi({
    this.m0mentCard,
    this.clBloc,
  });

  Widget build(BuildContext context) {
    //build the card
    var card = Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        m0mentCard.getImg(),
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
    Widget gestureDetector = new GestureDetector(
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
