import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/cardList_bloc.dart';
import 'package:m0ments/src/models/cardList_model.dart';
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
    CardListBloc _clBloc = BlocProvider.of<CardListBloc>(context);

    //Refresh Indicator
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        new GlobalKey<RefreshIndicatorState>();

    var _appBody = BlocBuilder(
      bloc: _clBloc,
      builder: (context, CardListState state) {
        return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: _clBloc.currentState.cardList.length,
                itemBuilder: (BuildContext context, int i) {
                  print(state.cardList[i].currentState.id);
                  return CardUi(m0mentCard: state.cardList[i], clBloc: _clBloc);
                },
              ),
            ));
      },
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
