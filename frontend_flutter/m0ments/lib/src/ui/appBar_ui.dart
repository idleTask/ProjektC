import 'package:flutter/material.dart';
import 'package:m0ments/src/ui/interfaceData.dart';



class AppBarUi extends StatelessWidget implements PreferredSizeWidget{
  final InterfaceData _interfaceData = new InterfaceData();
  @override
     Size get preferredSize => new Size.fromHeight(kToolbarHeight);
  
  final String title;

  AppBarUi({
    @required
    this.title,
  });

  @override
  Widget build(BuildContext context){
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: _interfaceData.getAppBarTextColor(),
        ),
      ),
      backgroundColor: _interfaceData.getAppBarBackgroundColor(),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.account_circle),
            color: _interfaceData.getAppBarTextColor(),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );

    
  }
}