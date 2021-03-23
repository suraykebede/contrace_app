import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';

class GetPhoneNumber extends StatefulWidget {
  String username;
  Color app_current_backround;
  Color app_current_text;
  GetPhoneNumber(
      {this.username, this.app_current_backround, this.app_current_text})
      : super();

  @override
  _GetPhoneNumberState createState() => _GetPhoneNumberState();
}

class _GetPhoneNumberState extends State<GetPhoneNumber> {
  bool getting_phonenumber = true;
  String phone_number;

  get_phonenumber() async {
    ResponseWithMsg res = await HttpService().get_phonenumber(widget.username);
    this.setState(() {
      phone_number = res.msg;
      getting_phonenumber = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => get_phonenumber(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!this.getting_phonenumber) {
      print('phone number ${this.phone_number}');
    }
    return getting_phonenumber
        ? Text('Please hold on')
        : Text(
            this.phone_number,
            style: TextStyle(color: widget.app_current_backround, fontSize: 20),
          );
  }
}
