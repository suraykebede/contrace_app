import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';

class GetFullName extends StatefulWidget {
  String username;
  Color app_current_backround;
  Color app_current_text;

  GetFullName(
      {this.username, this.app_current_backround, this.app_current_text})
      : super();

  @override
  _GetFullNameState createState() => _GetFullNameState();
}

class _GetFullNameState extends State<GetFullName> {
  bool getting_fullname = true;
  String fullname;

  get_fullname() async {
    ResponseWithMsg res = await HttpService().get_fullname(widget.username);
    this.setState(() {
      fullname = res.msg;
      getting_fullname = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => get_fullname(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!this.getting_fullname) {
      print('the url ${this.fullname}');
    }
    return getting_fullname
        ? Text('Please hold on')
        : Text(
            this.fullname,
            style: TextStyle(color: widget.app_current_backround, fontSize: 20),
          );
  }
}
