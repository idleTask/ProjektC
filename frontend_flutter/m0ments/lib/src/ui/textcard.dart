import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  final String descrText;

  TextCard(this.descrText);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: Card(
        elevation: 5,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 20),
          child: Text(
            descrText,
            style: TextStyle(fontSize: 17, textBaseline: TextBaseline.alphabetic),
          ),
        ),
      ),
    );
  }
}
