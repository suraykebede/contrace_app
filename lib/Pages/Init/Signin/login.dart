import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trace_et/Data/Constants/Colors/Init/header_colors.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'package:trace_et/Pages/Init/Signin/LoginComponents/logging_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username;
  String _password;
  bool _init_authentication = false;

  try_again() {
    setState(() {
      _init_authentication = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_init_authentication) {
      return LoggingIn(
        try_again: try_again,
        Username: _username,
        Password: _password,
      );
    } else {
      return Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0,
                  screenHeightExcludingToolbar(context, dividedBy: 25), 0, 0),
              child: Icon(
                Icons.account_circle,
                color: header_text_background_color,
                size: screenHeightExcludingToolbar(context, dividedBy: 15),
              ),
            ),
            SizedBox(
              height: screenHeightExcludingToolbar(context, dividedBy: 30),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _username = '@' + value;
                });
              },
              decoration: InputDecoration(
                  prefixText: '@',
                  hintText: 'username',
                  prefixIcon: Icon(Icons.person)),
            ),
            SizedBox(
              height: screenHeightExcludingToolbar(context, dividedBy: 30),
            ),
            TextField(
              obscureText: true,
              obscuringCharacter: "*",
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              decoration: InputDecoration(
                  hintText: 'Password', prefixIcon: Icon(Icons.security)),
            ),
            SizedBox(
              height: screenHeightExcludingToolbar(context, dividedBy: 30),
            ),
            RaisedButton.icon(
                color: header_text_color,
                onPressed: () {
                  setState(() {
                    _init_authentication = true;
                  });
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: header_text_background_color,
                ),
                label: Text(
                  'Log in',
                  style: TextStyle(color: header_text_background_color),
                ))
          ],
        ),
      );
    }
  }
}
