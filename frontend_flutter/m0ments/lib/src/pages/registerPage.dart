import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m0ments/src/blocs/profile_bloc.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:http/http.dart' as http;
import 'package:m0ments/src/resources/network_data.dart';

class RegisterPage extends StatefulWidget {
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  NetworkData _networkData = NetworkData();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  InterfaceData _interfaceData = InterfaceData();
  @override
  Widget build(BuildContext context) {
    void _registerFailedAlert() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: _interfaceData.getAppBarBackgroundColor(),
            title: new Text(
              "Register failed",
              style: TextStyle(
                  color: _interfaceData.getContainerColor(), fontSize: 18),
            ),
            content: new Text(
              "Please check your Username, Email or your password.",
              style: TextStyle(
                  color: _interfaceData.getContainerColor(), fontSize: 18),
            ),
            actions: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
                      child: RaisedButton(
                        elevation: 0,
                        highlightElevation: 0,
                        color: _interfaceData.getAppBarBackgroundColor(),
                        highlightColor: Theme.of(context).highlightColor,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _interfaceData.getAppBarTextColor(),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(26.0, 16, 26.0, 16),
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                color: _interfaceData.getContainerColor(),
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ]),
            ],
          );
        },
      );
    }

    var httpBody = {
      "name": _usernameController.text,
      "email": _emailController.text,
      "password": _passwordConfirmController.text
    };

    Future<http.Response> register() async {
      final response = await http
          .post(_networkData.getServerAdress() + 'user/signup', body: httpBody);

      if (response.statusCode == 200) {
        print("Register OK!");
        return json.decode(response.body);
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    }

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
          onChanged: (s) {
            print("Username: " + _usernameController.text);
          },
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
          onChanged: (s) {
            print("Email: " + _emailController.text);
          },
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
          onChanged: (s) {
            print("Password: " + _passwordController.text);
          },
          obscureText: true,
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
          onChanged: (s) {
            print("PasswordConfirm: " + _passwordConfirmController.text);
          },
          obscureText: true,
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
        onPressed: () {
          print("Register Button pressed");
          setState(() {
            if (_usernameController.text != null &&
                _emailController.text != null &&
                _passwordController != null &&
                _passwordConfirmController.text == _passwordController.text) {
              print("Daten OK, jetzt Register Call");
              register();
            } else {
              _registerFailedAlert();
            }
          });
        },
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
