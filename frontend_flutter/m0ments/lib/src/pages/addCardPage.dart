import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/cardList_bloc.dart';
import 'package:m0ments/src/blocs/m0mentCard_bloc.dart';
import 'package:m0ments/src/models/m0mentCard_model.dart';
import 'package:m0ments/src/resources/interfaceData.dart';

class AddCardPage extends StatefulWidget {
  AddCardPageState createState() => AddCardPageState();
}

class AddCardPageState extends State<AddCardPage> {
  InterfaceData _interfaceData = new InterfaceData();

  Widget build(BuildContext context) {
    CardListBloc _clBloc = BlocProvider.of<CardListBloc>(context);
    M0mentCardBloc _bloc = new M0mentCardBloc();

    var appBar = AppBar(
      title: Text(
        "Add Card",
        style: TextStyle(color: _interfaceData.getAppBarTextColor()),
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

    var floatingActionButton = Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, M0mentCard state) {
            return FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  print(_clBloc.currentState.cardList.length);
                  state.id = _clBloc.currentState.cardList.length;
                  _clBloc.onAddCard(_bloc.currentState);
                  Navigator.pop(context);
                });
              },
              label: Text("Submit"),
              icon: Icon(Icons.check),
              foregroundColor: _interfaceData.getAppBarTextColor(),
              backgroundColor: _interfaceData.getAppBarBackgroundColor(),
            );
          },
        ));

    var body = Container();
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
