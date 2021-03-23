import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trace_et/Data/Constants/Colors/Init/header_colors.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'package:trace_et/Pages/Init/Signin/SigninComponents/check_username.dart';
import 'package:trace_et/Utilities/show_messages.dart';

class UserIdentityInformation extends StatefulWidget {
  File clipped_image;
  String first_name;
  String last_name;
  String phone_number;
  String email;
  int age;
  String gender;

  UserIdentityInformation(
      {this.clipped_image,
      this.first_name,
      this.last_name,
      this.phone_number,
      this.email,
      this.age,
      this.gender})
      : super();

  @override
  _UserIdentityInformationState createState() =>
      _UserIdentityInformationState();
}

class _UserIdentityInformationState extends State<UserIdentityInformation> {
  String _username;
  String _password;
  bool isLoading = false;
  bool taken_username = false;
  String empty_fields = "";

  void call_for_taken() {
    setState(() {
      isLoading = false;
      taken_username = true;
    });
  }

  Widget before_checking() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          0, screenHeightExcludingToolbar(context, dividedBy: 80), 0, 0),
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: ClipOval(
                child: Image.file(widget.clipped_image),
              ),
              radius: screenWidth(context, dividedBy: 8),
            ),
            title: Text(widget.email),
            subtitle: Text(widget.phone_number),
            trailing: Text('${widget.gender}, ${widget.age}'),
          ),
          SizedBox(
              height: screenHeightExcludingToolbar(context, dividedBy: 30)),
          Container(
              padding: EdgeInsets.all(
                  screenHeightExcludingToolbar(context, dividedBy: 40)),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _username = '@' + value;
                  });
                },
                decoration: InputDecoration(
                    errorText: this.taken_username
                        ? 'That username is taken, ${this.empty_fields}'
                        : this.empty_fields,
                    prefixText: '@',
                    hintText: 'username',
                    prefixIcon: Icon(Icons.person)),
              )),
          SizedBox(
            height: screenHeightExcludingToolbar(context, dividedBy: 30),
          ),
          Container(
              padding: EdgeInsets.all(
                  screenHeightExcludingToolbar(context, dividedBy: 40)),
              child: TextField(
                obscureText: true,
                obscuringCharacter: "*",
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                decoration: InputDecoration(
                    errorText: (_password == null || _password.length < 9)
                        ? 'maximum password length is 9, ${this.empty_fields}'
                        : this.empty_fields,
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.security)),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: header_text_color,
            child: Icon(Icons.arrow_forward_ios),
            onPressed: () => {
                  print("username $_username password $_password"),
                  if (this._username != null &&
                      this._password != null &&
                      this._username.length >= 8 &&
                      this._password.length >= 9)
                    {
                      print("username $_username password $_password"),
                      this.setState(() {
                        isLoading = true;
                      })
                    }
                  else
                    {
                      if (this._username == null || this._password == null)
                        {empty_fields = "Fill empty fields"}
                      else
                        {
                          if (this._username.length < 8) {this}
                        }
                    }
                }),
        appBar: AppBar(
          backgroundColor: header_text_color,
          title: Text("${widget.first_name} ${widget.last_name}"),
        ),
        body: isLoading
            ? CheckUsername(
                clipped_image: widget.clipped_image,
                email: widget.email,
                first_name: widget.first_name,
                last_name: widget.last_name,
                password: _password,
                username: _username,
                phone_number: widget.phone_number,
                call_for_taken: call_for_taken,
                age: widget.age,
                gender: widget.gender)
            : before_checking());
  }
}
