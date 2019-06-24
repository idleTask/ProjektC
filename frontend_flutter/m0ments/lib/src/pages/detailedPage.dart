import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/cardList_bloc.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/models/cardList_model.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:m0ments/src/ui/textcard.dart';

class DetailedPage extends StatefulWidget {
  DetailedPageState createState() => DetailedPageState();
}

class DetailedPageState extends State<DetailedPage> {
  static InterfaceData _interfaceData = new InterfaceData();
  int upvotes = 2;

  Widget build(BuildContext context) {
    CardListBloc _clBloc = BlocProvider.of<CardListBloc>(context);
    M0mentCardBloc _bloc = BlocProvider.of<M0mentCardBloc>(context);

    var renderCard = BlocBuilder(
      bloc: _bloc,
      builder: (context, M0mentCard state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              state.img,
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            
          ),
        );
      },
    );

    var renderDescription = TextCard(
        "This is the test desription for the surprised pikatchu image. This is the test desription for the surprised pikatchu image. This is the test desribtion for the surprised pikatchu image. This is the test desribtion for the surprised pikatchu image.");

    var renderLikes = BlocBuilder(
      bloc: _bloc,
      builder: (context, M0mentCard state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.arrow_upward),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.id.toString(), style: TextStyle(fontSize: 17),),
                  ),
                  Icon(Icons.arrow_downward),
                ],
              ),
            ),
          ),
        );
      },
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
