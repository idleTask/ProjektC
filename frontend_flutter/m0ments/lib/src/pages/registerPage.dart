import 'package:flutter/material.dart';
import 'package:m0ments/src/resources/interfaceData.dart';

class RegisterPage extends StatefulWidget {
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  InterfaceData _interfaceData = InterfaceData();
  @override
  Widget build(BuildContext context) {
    var logoWidget = Align(
      alignment: Alignment.center,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "register",
            style: TextStyle(
              //fontFamily: null,
              fontSize: 40,
              color: _interfaceData.getAppBarTextColor(),
            ),
          ),
        ),
      ),
    );

    var usernameTextField = Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
      child: Theme(
        data: ThemeData(
            primaryColor: _interfaceData.getAppBarTextColor(),
            accentColor: _interfaceData.getAppBarBackgroundColor(),
            hintColor: _interfaceData.getContainerColor(),
            highlightColor: _interfaceData.getHighlightGrey()),
        child: TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: "Enter a username",
            border: OutlineInputBorder(),
          ),
          style: TextStyle(
              color: _interfaceData.getAppBarTextColor(), fontSize: 20),
          textAlign: TextAlign.center,
          cursorColor: _interfaceData.getAppBarTextColor(),
        ),
      ),
    );

    var emailTextField = Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
      child: Theme(
        data: ThemeData(
            primaryColor: _interfaceData.getAppBarTextColor(),
            accentColor: _interfaceData.getAppBarBackgroundColor(),
            hintColor: _interfaceData.getContainerColor(),
            highlightColor: _interfaceData.getHighlightGrey()),
        child: TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: "Enter your email",
            border: OutlineInputBorder(),
          ),
          style: TextStyle(
              color: _interfaceData.getAppBarTextColor(), fontSize: 20),
          textAlign: TextAlign.center,
          cursorColor: _interfaceData.getAppBarTextColor(),
        ),
      ),
    );

    var passwordTextField = Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
      child: Theme(
        data: ThemeData(
            primaryColor: _interfaceData.getAppBarTextColor(),
            accentColor: _interfaceData.getAppBarBackgroundColor(),
            hintColor: _interfaceData.getContainerColor(),
            highlightColor: _interfaceData.getHighlightGrey()),
        child: TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Enter a password",
            border: OutlineInputBorder(),
          ),
          style: TextStyle(
              color: _interfaceData.getAppBarTextColor(), fontSize: 20),
          textAlign: TextAlign.center,
          cursorColor: _interfaceData.getAppBarTextColor(),
        ),
      ),
    );

    var passwordConfirmTextField = Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
      child: Theme(
        data: ThemeData(
            primaryColor: _interfaceData.getAppBarTextColor(),
            accentColor: _interfaceData.getAppBarBackgroundColor(),
            hintColor: _interfaceData.getContainerColor(),
            highlightColor: _interfaceData.getHighlightGrey()),
        child: TextField(
          controller: _passwordConfirmController,
          decoration: InputDecoration(
            hintText: "Confirm your password",
            border: OutlineInputBorder(),
          ),
          style: TextStyle(
              color: _interfaceData.getAppBarTextColor(), fontSize: 20),
          textAlign: TextAlign.center,
          cursorColor: _interfaceData.getAppBarTextColor(),
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
            color: _interfaceData.getAppBarTextColor(),
          ),
        ),
        onPressed: () {},
        color: _interfaceData.getAppBarBackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Register",
            style: TextStyle(
                color: _interfaceData.getContainerColor(), fontSize: 18),
          ),
        ),
      ),
    );

    var loginTextField = new GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "LoginPage");
        },
        child: Text(
          "Already have an account? Click here to login.",
          style: TextStyle(color: _interfaceData.getContainerColor()),
        ));

    var buttonWidgets = Column(
      children: <Widget>[
        registerButton,
        loginTextField,
      ],
    );

    var registerWidgets = Column(
      children: <Widget>[
        usernameTextField,
        emailTextField,
        passwordTextField,
        passwordConfirmTextField,
      ],
    );

    var _appBody = Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        logoWidget,
        registerWidgets,
        buttonWidgets,
      ],
    ));

    return Scaffold(
      backgroundColor: _interfaceData.getAppBarBackgroundColor(),
      appBar: null,
      body: _appBody,
    );
  }
}
