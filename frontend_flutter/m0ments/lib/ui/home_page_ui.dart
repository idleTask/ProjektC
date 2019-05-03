import 'package:flutter/material.dart';
import 'package:m0ments/src/card_data.dart';
import 'package:m0ments/ui/interfaceData.dart';
import 'package:m0ments/ui/drawer_ui.dart';
import 'package:m0ments/ui/appBar_ui.dart';

//refresh Page with data
Future<Null> _refresh(){
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
  
  child:  RefreshIndicator(
  key: _refreshIndicatorKey,
  onRefresh: _refresh,
  child: Container(
      child: GridView.count(
        crossAxisCount: 3,
        children: <Widget>[CardData(), CardData(), CardData(), CardData()],
      ),
    )
  ),
); 

return Scaffold(
  drawer: DrawerUi(),
  appBar: AppBarUi(title: title,),
  body: _appBody,
);
}
}
