import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';

class FullName extends StatefulWidget {
  String username;
  Color app_background_color;

  FullName({this.username, this.app_background_color});

  @override
  _FullNameState createState() => _FullNameState();
}

class _FullNameState extends State<FullName> {
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

  String fullname;
  bool getting_fullname = true;

  @override
  Widget build(BuildContext context) {
    return getting_fullname
        ? Text(
            widget.username,
            style: TextStyle(color: widget.app_background_color),
          )
        : Text(
            fullname,
            style: TextStyle(color: widget.app_background_color),
          );
  }
}
