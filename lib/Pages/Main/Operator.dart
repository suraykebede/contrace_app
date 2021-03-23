import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Data/Constants/Colors/App/dark_variants.dart';
import 'package:trace_et/Data/Constants/Colors/Init/header_colors.dart';
import './Pages/Home/Home.dart';
import 'package:trace_et/Utilities/get_device_id.dart';

class Operator extends StatefulWidget {
  String username;
  bool forward;

  Operator({this.username, this.forward}) : super();

  @override
  _OperatorState createState() => _OperatorState();
}

class _OperatorState extends State<Operator> {
  Color app_current_background = header_text_color;
  Color app_current_text = header_text_background_color;
  bool dummy_operator = true;
  String response_from_server;
  bool eng = true;

  void to_dark() {
    setState(() {
      app_current_background = app_dark_background;
      app_current_text = app_dark_text;
    });
  }

  void to_light() {
    setState(() {
      app_current_background = header_text_color;
      app_current_text = header_text_background_color;
    });
  }

  void switch_language() {
    setState(() {
      eng = !eng;
    });
  }

  void add_this_device() async {
    String username = widget.username;
    String device_id = await get_device_id();
    ResponseWithMsg res = await HttpService()
        .add_device(device_id: device_id, username: username);
    String response = res.msg;
    setState(() {
      dummy_operator = false;
      response_from_server = response;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => add_this_device(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool signing_in = widget.forward;
    if (signing_in) {
      if (dummy_operator) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Home(
          switcher: switch_language,
          lang: eng,
          username: widget.username,
          to_dark: to_dark,
          to_light: to_light,
          app_current_background: app_current_background,
          app_current_text: app_current_text,
        );
      }
    } else {
      return Home(
        switcher: switch_language,
        lang: eng,
        username: widget.username,
        to_dark: to_dark,
        to_light: to_light,
        app_current_background: app_current_background,
        app_current_text: app_current_text,
      );
    }
  }
}
