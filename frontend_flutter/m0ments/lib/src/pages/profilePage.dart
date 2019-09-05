import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/profile_bloc.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:m0ments/src/ui/appBar_ui.dart';
import 'package:m0ments/src/ui/textcard.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  InterfaceData _interfaceData = InterfaceData();

  @override
  Widget build(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    var _appBody = ListView(
      children: <Widget>[
        TextCard("Username: " + _profileBloc.currentState.username),
        TextCard("E-Mail Adress: " + _profileBloc.currentState.email),
        /*GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: _clBloc.currentState.cardList.length,
          itemBuilder: (BuildContext context, int i) {
            return CardUi(m0mentCard: state.cardList[i], clBloc: _clBloc);
          },
        ),*/
      ],
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
