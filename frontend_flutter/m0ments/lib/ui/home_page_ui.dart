import 'package:flutter/material.dart';
import 'package:m0ments/src/card_data.dart';

//Variablen
final Color _appBarTextColor = Colors.red[300];
final Color _appBarBackgroundColor = Colors.blueGrey[800];
final Color _containerColor = Colors.blueGrey[900];

//Methode um Text universelll schwarz zu machen
Text coloredText(String text) {
  return Text(
    text,
    style: TextStyle(color: _appBarTextColor),
  );
}

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
    //Der Drawer
    final _drawerUi = Drawer(
      child: Container(
        color: _appBarBackgroundColor,
        child: ListView(
          children: <Widget>[
            Container(
              color: _containerColor,
              child: DrawerHeader(
                child: coloredText('Custom Header'),
                decoration: BoxDecoration(
                    //color: Colors.blue,
                    ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: coloredText('First layout'),
            ),
            ListTile(
              title: coloredText('Communicate'),
              //without leading =)
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: coloredText('Share layout'),
            )
          ],
        ),
      ),
    );

    //AppBar des HomeScreens
    final _appBar = AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: _appBarTextColor,
        ),
      ),
      backgroundColor: _appBarBackgroundColor,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.account_circle),
            color: _appBarTextColor,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );

    return Scaffold(
      drawer: _drawerUi,
      appBar: _appBar,
      body: CardData(),
    );
  }
}
