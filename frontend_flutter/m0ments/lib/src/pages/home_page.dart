import 'package:flutter/material.dart';
import 'package:m0ments/src/ui/home_page_ui.dart';

//refresh Page with data
Future<Null> _refresh(){
  return null;
}

class HomePage extends StatefulWidget {
  final String title = "m0ments";
  const HomePage();

  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  //Refresh Indicator
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: HomePageUi(title: widget.title,),
        ),
    );
  }
}
