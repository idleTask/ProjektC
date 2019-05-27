import 'package:flutter/material.dart';
import 'package:m0ments/src/ui/interfaceData.dart';

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
            child: _interfaceData.coloredText('Custom Header'),
            decoration: BoxDecoration(
                //color: Colors.blue,
                ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: _interfaceData.coloredText('First layout'),
        ),
        ListTile(
          title: _interfaceData.coloredText('Communicate'),
          //without leading =)
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: _interfaceData.coloredText('Share layout'),
        )
      ],
    ),
  ),
);
  }
}