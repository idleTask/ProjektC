import 'package:flutter/material.dart';
import 'package:m0ments/src/ui/card_ui.dart';

class DetailedPage extends StatefulWidget {
  DetailedPageState createState() => DetailedPageState();
}

class DetailedPageState extends State<DetailedPage> {
  var renderCard = null;

  Widget renderContent = Container();

  var renderMain = Scaffold(
    appBar: AppBar(
      title: Text("test"),
    ),
    body: Container(
      child: CardUi(img: "lib/src/resources/images/surprised_pikatchu.png"),
    ),
  );

  Widget build(BuildContext context) {
    return renderMain;
  }
}
