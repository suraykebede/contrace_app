import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Objects/signup_auth_object.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Data/Constants/Colors/Init/header_colors.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'package:trace_et/Pages/Main/Operator.dart';

class AddUser extends StatefulWidget {
  File image;
  String first_name;
  String last_name;
  String gender;
  String username;
  String password;
  String email;
  int age;
  String phone_number;
  double home_latitude;
  double home_longitude;

  AddUser(
      {this.image,
      this.first_name,
      this.last_name,
      this.age,
      this.email,
      this.gender,
      this.password,
      this.phone_number,
      this.username,
      this.home_latitude,
      this.home_longitude});

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  add_user() async {
    bool file_exists = await widget.image.exists();
    print('whether or not the file exists is $file_exists');
    print('email = ${widget.email}');
    final bytes = widget.image.readAsBytesSync();
    String image = base64.encode(bytes);
    print(image.substring(1, 10));

    SignupAuthObject signup_auth_obj = new SignupAuthObject(
        current_venue: "NON",
        email: widget.email,
        first_name: widget.first_name,
        gender: widget.gender,
        home_latitude: widget.home_latitude,
        home_longitude: widget.home_longitude,
        image: image,
        last_name: widget.last_name,
        password: widget.password,
        phone_number: widget.phone_number,
        psh_key: "NON",
        age: widget.age,
        username: widget.username);

    ResponseWithMsg res = await HttpService().add_user(signup_auth_obj);
    print("response from the server: ${res.msg}");
    setState(() {
      //response = res.msg;
      if (res.msg == "USER_ADDED") {
        response = "Account has been created";
      } else {
        response = "Unable to create account";
      }
      is_loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => add_user(),
    );
  }

  Widget when_loading() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(screenWidth(context, dividedBy: 20),
          screenHeightExcludingToolbar(context, dividedBy: 3), 0, 0),
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: screenHeightExcludingToolbar(context, dividedBy: 20),
          ),
          Text(
            'Creating account',
            style: TextStyle(color: header_text_color, fontSize: 25),
          ),
        ],
      ),
    );
  }

  Widget when_done(String response) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(screenWidth(context, dividedBy: 20),
          screenHeightExcludingToolbar(context, dividedBy: 3), 0, 0),
      child: Column(
        children: [
          response == 'Account has been created'
              ? Icon(
                  Icons.check,
                  size: 35,
                )
              : Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
          SizedBox(
            height: screenHeightExcludingToolbar(context, dividedBy: 20),
          ),
          Text(
            response,
            style: TextStyle(color: header_text_color, fontSize: 25),
          ),
          RaisedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Operator(
                              username: widget.username,
                              forward: false,
                            )));
              },
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('Continue'))
        ],
      ),
    );
  }

  String response;
  bool is_loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: header_text_color,
        title: Text('Account Creation'),
        centerTitle: true,
      ),
      body: is_loading ? when_loading() : when_done(response),
    );
  }
}
