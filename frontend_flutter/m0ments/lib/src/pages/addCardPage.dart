import 'package:flutter/material.dart';
import 'package:m0ments/src/resources/interfaceData.dart';

class AddCardPage extends StatelessWidget{
  InterfaceData _interfaceData = new InterfaceData();
  Widget build(BuildContext context){
    
    var appBar = AppBar(
      title: Text("Add Card", style: TextStyle(color: _interfaceData.getAppBarTextColor()),),
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
      child: FloatingActionButton.extended(
        onPressed: (){},
        label: Text("Submit"),
        icon: Icon(Icons.check),
        foregroundColor: _interfaceData.getAppBarTextColor(),
        backgroundColor: _interfaceData.getAppBarBackgroundColor(),
      ),
    );
    var body = Container();
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}