import 'package:flutter/material.dart';
import 'package:m0ments/src/ui/card_ui.dart';
import 'package:m0ments/src/ui/interfaceData.dart';
import 'package:m0ments/src/ui/drawer_ui.dart';
import 'package:m0ments/src/ui/appBar_ui.dart';

//refresh Page with data
Future<Null> _refresh() {
  return null;
}

//Variablen
final InterfaceData _interfaceData = new InterfaceData();

//HomePageUi widget für home_page.dart
class HomePageUi extends StatelessWidget {
  //Variablen
  final String title;

  //Konstruktor
  const HomePageUi({
    this.title,
  });

//Build Funktion
  Widget build(BuildContext context) {
//Refresh Indicator
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        new GlobalKey<RefreshIndicatorState>();

    final _appBody = Container(
      child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: Container(
            child: GridView.count(
              crossAxisCount: 3,
              children: <Widget>[
                CardUi(img: "lib/src/resources/images/surprised_pikatchu.png"),
                CardUi(img: "lib/src/resources/images/surprised_pikatchu.png"),
                CardUi(img: "lib/src/resources/images/surprised_pikatchu.png"),
                CardUi(img: "lib/src/resources/images/surprised_pikatchu.png")
              ],
            ),
          )),
    );

    return Scaffold(
      drawer: DrawerUi(),
      appBar: AppBarUi(
        title: title,
      ),
      body: _appBody,
    );
  }
}
