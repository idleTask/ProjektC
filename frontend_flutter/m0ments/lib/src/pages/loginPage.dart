import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:m0ments/src/pages/homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    InterfaceData interfaceData = new InterfaceData();

    var logoWidget = Align(
      alignment: Alignment.center,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "m0ments",
            style: TextStyle(
              //fontFamily: null,
              fontSize: 40,
              color: interfaceData.getAppBarTextColor(),
            ),
          ),
        ),
      ),
    );

    //TODO: Muss so gemacht werden, dass wenn man wo anders klickt, der Highlight auf dem TextField weg ist
    var usernameWidget = Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
      child: Theme(
        data: ThemeData(
          primaryColor: interfaceData.getAppBarTextColor(),
          accentColor: interfaceData.getAppBarBackgroundColor(),
          hintColor: interfaceData.getContainerColor(),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: interfaceData.getAppBarTextColor(), fontSize: 20),
          textAlign: TextAlign.center,
          cursorColor: interfaceData.getAppBarTextColor(),
        ),
      ),
    );

    var passwordWidget = Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
      child: Theme(
        data: ThemeData(
          primaryColor: interfaceData.getAppBarTextColor(),
          accentColor: interfaceData.getAppBarBackgroundColor(),
          hintColor: interfaceData.getContainerColor(),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: interfaceData.getAppBarTextColor(), fontSize: 20),
          textAlign: TextAlign.center,
          cursorColor: interfaceData.getAppBarTextColor(),
        ),
      ),
    );

    //TODO: Der ist aktuell manuell "gesized" mit Padding damit er so groß ist wie der Register Button. Also beide auf eine Größe bringen.
    var loginButton = Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
      child: RaisedButton(
        elevation: 0,
        highlightElevation: 0,
        shape: OutlineInputBorder(
          borderSide: BorderSide(
            color: interfaceData.getAppBarTextColor(),
          ),
        ),
        onPressed: () {
          print("login");
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        color: interfaceData.getAppBarBackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26.0, 16, 26.0, 16),
          child: Text(
            "Login",
            style: TextStyle(color: interfaceData.getContainerColor(), fontSize: 18),
          ),
        ),
      ),
    );

    var registerButton = Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
      child: RaisedButton(
        elevation: 0,
        highlightElevation: 0,
        shape: OutlineInputBorder(
          borderSide: BorderSide(
            color: interfaceData.getContainerColor(),
          ),
        ),
        onPressed: () {
          print("register");
        },
        color: interfaceData.getAppBarBackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Register",
            style: TextStyle(color: interfaceData.getContainerColor(), fontSize: 18),
          ),
        ),
      ),
    );

    var loginWidget = Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              usernameWidget,
              passwordWidget,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  loginButton,
                  registerButton,
                ],
              ),
            ],
          ),
        ),
      ),
    );

    var _appBody = Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        logoWidget,
        loginWidget,
      ],
    ));

    return Scaffold(
      backgroundColor: interfaceData.getAppBarBackgroundColor(),
      appBar: null,
      body: _appBody,
    );
  }
}
