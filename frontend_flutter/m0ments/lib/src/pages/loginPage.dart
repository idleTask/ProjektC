import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m0ments/src/resources/interfaceData.dart';
import 'package:m0ments/src/pages/homePage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage();

  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    InterfaceData interfaceData = new InterfaceData();

    var token = "";
    var email = "";
    var password = "G5lQJ5Sm0f5cupxe";
    var url = 'http://localhost:3000/user/login';
    var loginBody = {"email": email, "password": password};

    void updateLoginBody(String email, String password) {
      loginBody = {"email": email, "password": password};
    }

    void _loginFailedAlert() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: interfaceData.getAppBarBackgroundColor(),
            title: new Text(
              "Login failed",
              style: TextStyle(
                  color: interfaceData.getContainerColor(), fontSize: 18),
            ),
            content: new Text(
              "Please check your Email or your password.",
              style: TextStyle(
                  color: interfaceData.getContainerColor(), fontSize: 18),
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
                        color: interfaceData.getAppBarBackgroundColor(),
                        highlightColor: Theme.of(context).highlightColor,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: interfaceData.getAppBarTextColor(),
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
                                color: interfaceData.getContainerColor(),
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

    Future<Login> tryLogin() async {
      final response = await http.post(url, body: loginBody);

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        print("Login OK");
        print(json.decode(response.body));
        return Login.fromJson(json.decode(response.body));
      } else {
        // If that response was not OK, throw an error.
        print("Login failed");
        _loginFailedAlert();
        //throw Exception(response.body);
      }
    }

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

    var emailWidget = Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
      child: Theme(
        data: ThemeData(
            primaryColor: interfaceData.getAppBarTextColor(),
            accentColor: interfaceData.getAppBarBackgroundColor(),
            hintColor: interfaceData.getContainerColor(),
            highlightColor: interfaceData.getHighlightGrey()),
        child: TextField(
          onChanged: (text) {
            email = text;
            updateLoginBody(email, password);
            print(email);
          },
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(),
          ),
          style: TextStyle(
              color: interfaceData.getAppBarTextColor(), fontSize: 20),
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
          onChanged: (text) {
            password = text;
            updateLoginBody(email, password);
            print(password);
          },
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(),
          ),
          style: TextStyle(
              color: interfaceData.getAppBarTextColor(), fontSize: 20),
          textAlign: TextAlign.center,
          cursorColor: interfaceData.getAppBarTextColor(),
        ),
      ),
    );

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
          print("login button pressed");
          print("try login with $email and $password");
          updateLoginBody(email, password);
          tryLogin().then((result) {
            setState(() {
              if (result.message == "Auth successful") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              }
            });
          });
        },
        color: interfaceData.getAppBarBackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26.0, 16, 26.0, 16),
          child: Text(
            "Login",
            style: TextStyle(
                color: interfaceData.getContainerColor(), fontSize: 18),
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
            style: TextStyle(
                color: interfaceData.getContainerColor(), fontSize: 18),
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
              emailWidget,
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

class Login {
  final String message;
  final String token;

  Login({
    this.message,
    this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      message: json['message'],
      token: json['token'],
    );
  }
}
