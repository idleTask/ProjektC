import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:m0ments/src/blocs/cardList_bloc.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/blocs/profile_bloc.dart';
import 'package:m0ments/src/models/cardList_model.dart';
import 'package:m0ments/src/pages/addCardPage.dart';
import 'package:m0ments/src/ui/appBar_ui.dart';
import 'package:m0ments/src/ui/card_ui.dart';
import 'package:m0ments/src/ui/drawer_ui.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:m0ments/src/resources/network_data.dart';
import 'package:m0ments/src/resources/pojo_Items.dart';

class HomePage extends StatefulWidget {
  final String title = "m0ments";
  const HomePage();

  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    InterfaceData _interfaceData = new InterfaceData();
    NetworkData _networkData = NetworkData();
    CardListBloc _clBloc = BlocProvider.of<CardListBloc>(context);
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    void _loadingFailedAlert() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: _interfaceData.getAppBarBackgroundColor(),
            title: new Text(
              "Loading posts failed",
              style: TextStyle(
                  color: _interfaceData.getContainerColor(), fontSize: 18),
            ),
            content: new Text(
              "Please check your internet connection and try again.",
              style: TextStyle(
                  color: _interfaceData.getContainerColor(), fontSize: 18),
            ),
            actions: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
                      child: RaisedButton(
                        elevation: 0,
                        highlightElevation: 0,
                        color: _interfaceData.getAppBarBackgroundColor(),
                        highlightColor: Theme.of(context).highlightColor,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _interfaceData.getAppBarTextColor(),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(26.0, 16, 26.0, 16),
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                color: _interfaceData.getContainerColor(),
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ]),
            ],
          );
        },
      );
    }

    //Refresh Indicator
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        new GlobalKey<RefreshIndicatorState>();

    Future<Items> _getItems() async {
      final response = await http.get(_networkData.getServerAdress() + "items",
          headers: _networkData
              .getAuthHeaderApplicationJson(_profileBloc.currentState.token));

      if (response.statusCode == 200) {
        print("refresh Ok");
        return Items.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        // If that response was not OK, throw an error.
        _loadingFailedAlert();
      }
    }

    //refresh Page with data
    Future<Items> _refresh() async {
      return _getItems().then((result) {
        _clBloc.onRemoveAllCards();
        _clBloc.currentState.count = result.count;

        for (int i = 0; i < result.items.length; i++) {
          M0mentCardBloc tempBloc = M0mentCardBloc();
          tempBloc.currentState.id = result.items[i].id;
          tempBloc.currentState.userId = result.items[i].userId;
          tempBloc.currentState.title = result.items[i].title;
          tempBloc.currentState.descr = result.items[i].description;
          tempBloc.currentState.img = result.items[i].itemImage;
          _clBloc.onAddCard(tempBloc);
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());

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
                  return CardUi(
                    m0mentCard: state.cardList[i], /* clBloc: _clBloc*/
                  );
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
