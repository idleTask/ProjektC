import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/pages/addCardPage.dart';
import 'package:m0ments/src/ui/appBar_ui.dart';
import 'package:m0ments/src/ui/card_ui.dart';
import 'package:m0ments/src/ui/drawer_ui.dart';
import 'package:m0ments/src/resources/interfaceData.dart';

//refresh Page with data
Future<Null> _refresh() {
  return null;
}

class HomePage extends StatefulWidget {
  final String title = "m0ments";
  const HomePage();

  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    InterfaceData _interfaceData = new InterfaceData();
    List<M0mentCardBloc> cardBlocs;

    //Refresh Indicator
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        new GlobalKey<RefreshIndicatorState>();

    var _appBody = Container(
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

    var floatingActionButton = Padding(
      padding: EdgeInsets.all(8),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCardPage()),
          );
        },
        child: Icon(Icons.add),
        foregroundColor: _interfaceData.getAppBarTextColor(),
        backgroundColor: _interfaceData.getAppBarBackgroundColor(),
      ),
    );

    return Scaffold(
      drawer: DrawerUi(),
      appBar: AppBarUi(
        title: widget.title,
      ),
      floatingActionButton: floatingActionButton,
      body: _appBody,
    );
  }
}
