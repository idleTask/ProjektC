import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:m0ments/src/ui/textcard.dart';

class ImpressumPage extends StatelessWidget {
  InterfaceData _interfaceData = InterfaceData();
  @override
  Widget build(BuildContext context) {

    var _appBody = TextCard("Das ist das Imressum von Basti, Joel und André");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Impressum",
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
