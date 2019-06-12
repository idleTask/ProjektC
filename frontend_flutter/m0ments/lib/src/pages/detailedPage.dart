import 'package:flutter/material.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:m0ments/src/ui/textcard.dart';

class DetailedPage extends StatefulWidget {
  DetailedPageState createState() => DetailedPageState();
}

class DetailedPageState extends State<DetailedPage> {
  static InterfaceData _interfaceData = new InterfaceData();
  int upvotes = 2;

  Widget build(BuildContext context) {
    String img = "lib/src/resources/images/surprised_pikatchu.png";

    var renderCard = new Card(
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

    var renderDescription = new TextCard(
        "This is the test desribtion for the surprised pikatchu image. This is the test desribtion for the surprised pikatchu image. This is the test desribtion for the surprised pikatchu image. This is the test desribtion for the surprised pikatchu image.");

    var renderLikes = Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_upward),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(upvotes.toString()),
            ),
            Icon(Icons.arrow_downward),
          ],
        ),
      ),
    );

    var renderAppBar = AppBar(
      title: Text(
        "title",
        style: TextStyle(
          color: _interfaceData.getAppBarTextColor(),
        ),
      ),
      backgroundColor: _interfaceData.getAppBarBackgroundColor(),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: _interfaceData.getAppBarTextColor(),
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );

    var renderBody = ListView(
      children: <Widget>[
        renderCard,
        renderLikes,
        renderDescription,
      ],
    );

    var renderMain = Scaffold(
      appBar: renderAppBar,
      body: Container(
        child: renderBody,
      ),
    );

    return renderMain;
  }
}
