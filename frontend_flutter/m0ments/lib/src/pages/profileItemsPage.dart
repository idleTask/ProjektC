import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:m0ments/src/blocs/profile_bloc.dart';
import 'package:m0ments/src/ui/card_ui.dart';

class ProfileItemsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileItemsPageState();
  }
}

class ProfileItemsPageState extends State<ProfileItemsPage> {
  InterfaceData _interfaceData = InterfaceData();

  @override
  Widget build(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    Widget _appBody =  
      GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: _profileBloc.currentState.cardList.length,
        itemBuilder: (BuildContext context, int i) {
          return CardUi(
            m0mentCard:
                _profileBloc.currentState.cardList[i], /* clBloc: _clBloc*/
          );
        },
      );
    

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: _interfaceData.getAppBarTextColor(),
          ),
        ),
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
        backgroundColor: _interfaceData.getAppBarBackgroundColor(),
      ),
      body: _appBody,
    );
  }
}
