import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Pages/Init/Signin/SigninComponents/get_coordinates.dart';

class CheckUsername extends StatefulWidget {
  File clipped_image;
  String first_name;
  String last_name;
  String phone_number;
  String email;
  String username;
  String password;
  int age;
  String gender;
  Function call_for_taken;

  CheckUsername(
      {this.clipped_image,
      this.first_name,
      this.last_name,
      this.email,
      this.username,
      this.password,
      this.phone_number,
      this.call_for_taken,
      this.age,
      this.gender});

  @override
  _CheckUsernameState createState() => _CheckUsernameState();
}

class _CheckUsernameState extends State<CheckUsername> {
  verify_user() async {
    ResponseWithMsg res_msg =
        await HttpService().verify_username(widget.username);
    String msg = res_msg.msg;
    if (msg == 'NON_EXISTS') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GetCoordinates(
                    age: widget.age,
                    clipped_image: widget.clipped_image,
                    email: widget.email,
                    first_name: widget.first_name,
                    gender: widget.gender,
                    last_name: widget.last_name,
                    password: widget.password,
                    phone_number: widget.phone_number,
                    username: widget.username,
                  )));
    } else {
      widget.call_for_taken();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => verify_user(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.username);
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
