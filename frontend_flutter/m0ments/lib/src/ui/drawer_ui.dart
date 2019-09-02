import 'package:flutter/material.dart';
import 'package:m0ments/src/resources/interfaceData.dart';

class DrawerUi extends StatelessWidget{

  final InterfaceData _interfaceData = new InterfaceData();

  @override
  Widget build(BuildContext context){
    //Der Drawer
return Drawer(
  child: Container(
    color: _interfaceData.getAppBarBackgroundColor(),
    child: ListView(
      children: <Widget>[
        Container(
          color: _interfaceData.getContainerColor(),
          child: DrawerHeader(
            child: _interfaceData.coloredText('Profile'),
            decoration: BoxDecoration(
                //color: Colors.blue,
                ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: _interfaceData.coloredText('My Posts'),
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: _interfaceData.coloredText('Impressum'),
        ),
        ListTile(
          leading: Icon(Icons.close),
          title: _interfaceData.coloredText('Logout'),
          onTap: (){
            Navigator.pushNamed(context, "LoginPage");
          },
        ),
      ],
    ),
  ),
);
  }
}