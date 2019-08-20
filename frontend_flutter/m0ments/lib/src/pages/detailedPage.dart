import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/cardList_bloc.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/models/cardList_model.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:m0ments/src/ui/textcard.dart';

class DetailedPage extends StatefulWidget {
  final M0mentCardBloc bloc;
  DetailedPage({
    @required this.bloc,
  });

  DetailedPageState createState() => DetailedPageState();
}

class DetailedPageState extends State<DetailedPage> {
  static InterfaceData _interfaceData = new InterfaceData();
  int upvotes = 2;

  Widget build(BuildContext context) {
    CardListBloc _clBloc = BlocProvider.of<CardListBloc>(context);
    M0mentCardBloc bloc = widget.bloc;
    bool upVoted = false;

    print("detailedPage:");
    print(bloc.currentState);

    var renderCard = BlocBuilder(
      bloc: bloc,
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
      bloc.currentState.getDescr()
    );
    
    var renderLikes = BlocBuilder(
      bloc: bloc,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_upward),
                          splashColor: Colors.orange[300],
                          onPressed: () {
                            setState(() {
                              bloc.upvote();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          state.votes.toString(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_downward),
                          splashColor: Colors.blue[400],
                          onPressed: () {
                            setState(() {
                              bloc.downvote();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "ID: " + state.id.toString(),
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    var renderAppBar = AppBar(
      title: Text(
        bloc.currentState.getTitle(),
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
