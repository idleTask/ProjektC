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

    //Refresh Indicator
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        new GlobalKey<RefreshIndicatorState>();

    Future<Items> _getItems() async {
      print("trying refresh with:  " +
          _networkData.getServerAdress() +
          "items" +
          "  and   " +
          _profileBloc.currentState.token);
      final response = await http.get(_networkData.getServerAdress() + "items",
          headers: _networkData
              .getAuthorizationHeader(_profileBloc.currentState.token));

      if (response.statusCode == 200) {
        print("refresh Ok");
        print(json.decode(response.body));
        return Items.fromJson(json.decode(response.body));
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    }

    //refresh Page with data
    Future<Items> _refresh() async {
      return _getItems().then((result) {
        setState(() {
          _clBloc.onRemoveAllCards();
          _clBloc.currentState.count = result.count;

          for (int i = 0; i < result.items.length; i++) {
            M0mentCardBloc tempBloc = M0mentCardBloc();
            tempBloc.currentState.id = result.items[i].id;
            tempBloc.currentState.userId = result.items[i].userId;
            tempBloc.currentState.title = result.items[i].title;
            tempBloc.currentState.descr = result.items[i].description;
            //tempBloc.currentState.img = result.items[i].itemImage;
            _clBloc.onAddCard(tempBloc);
          }
        });
      });
    }

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

class Items {
  final int count;
  final List<Item> items;

  Items({this.count, this.items});

  factory Items.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> itemsList = list.map((i) => Item.fromJson(i)).toList();
    return Items(
      count: json['count'],
      items: itemsList,
    );
  }
}

class Item {
  final String id;
  final String title;
  final String description;
  final String itemImage;
  final String userId;

  Item({this.id, this.title, this.description, this.itemImage, this.userId});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      itemImage: json['itemImage'],
      userId: json['userId'],
    );
  }
}
