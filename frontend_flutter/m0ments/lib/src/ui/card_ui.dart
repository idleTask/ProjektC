import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:m0ments/src/blocs/cardList_bloc.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/blocs/profile_bloc.dart';
import 'package:m0ments/src/pages/detailedPage.dart';
import 'package:m0ments/src/resources/network_data.dart';

class CardUi extends StatelessWidget {
  //final CardListBloc clBloc;
  final M0mentCardBloc m0mentCard;

  const CardUi({
    this.m0mentCard,
    //this.clBloc,
  });

  Widget build(BuildContext context) {
    NetworkData _networkData = NetworkData();
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    File cardImage = new File(
        "/Users/andrevoroschilin/Desktop/Projekt C/frontend_flutter/m0ments/lib/src/resources/images/surprised_pikatchu.png");

    Future<FileResponse> getItemImage() async {
      final response = await http.get(
          _networkData.getServerAdress() + m0mentCard.currentState.getImg(),
          headers: _networkData
              .getAuthHeaderImageJpeg(_profileBloc.currentState.token));

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        return FileResponse.fromJson(json.decode(response.body));
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    }

/*
    saveLocally() {
      getItemImage().then((result) {
        cardImage = result.itemImage;
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => saveLocally());
*/
    //build the card
    var card = Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        _networkData.getServerAdress() + "surprised_pikatchu.png",
        headers: _networkData.getAuthHeaderImageJpeg(_profileBloc.currentState.token),
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
      onTap: () {
        print("Card_ui:");
        print(m0mentCard.currentState);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedPage(bloc: m0mentCard),
          ),
        );
      },
      child: sizedBox,
    );

    //return the build
    return gestureDetector;
  }
}

class FileResponse {
  final File itemImage;

  FileResponse({this.itemImage});

  factory FileResponse.fromJson(Map<String, dynamic> json) {
    return FileResponse(
      itemImage: json['itemImage'],
    );
  }
}
