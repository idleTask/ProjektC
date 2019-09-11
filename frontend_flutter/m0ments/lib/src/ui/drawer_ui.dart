import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/profile_bloc.dart';
import 'package:m0ments/src/pages/impressumPage.dart';
import 'package:m0ments/src/pages/profileItemsPage.dart';
import 'package:m0ments/src/pages/profilePage.dart';
import 'package:m0ments/src/resources/interfaceData.dart';

class DrawerUi extends StatelessWidget {
  final InterfaceData _interfaceData = new InterfaceData();

  @override
  Widget build(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    //Der Drawer
    return Drawer(
      child: Container(
        color: _interfaceData.getAppBarBackgroundColor(),
        child: ListView(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.account_circle),
                title: _interfaceData.coloredText("My Profile"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                }),
            ListTile(
              leading: Icon(Icons.photo),
              title: _interfaceData.coloredText('My Posts'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileItemsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: _interfaceData.coloredText('Impressum'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImpressumPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: _interfaceData.coloredText('Logout'),
              onTap: () {
                Navigator.pushNamed(context, "LoginPage");
              },
            ),
          ],
        ),
      ),
    );
  }
}
