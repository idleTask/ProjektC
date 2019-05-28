import 'package:flutter/material.dart';
import 'package:m0ments/src/resources/interfaceData.dart';

class DetailedPage extends StatefulWidget {
  DetailedPageState createState() => DetailedPageState();
}

class DetailedPageState extends State<DetailedPage> {
  static InterfaceData _interfaceData = new InterfaceData();

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

    var renderMain = Scaffold(
      appBar: renderAppBar,
      body: Container(
        child: renderCard,
      ),
    );

    return renderMain;
  }
}
