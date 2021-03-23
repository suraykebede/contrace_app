import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Pages/Init/sign_in_prompt_page.dart';
import 'package:trace_et/Pages/Main/Operator.dart';

class InitialLoadingPage extends StatefulWidget {
  @override
  _InitialLoadingPageState createState() => _InitialLoadingPageState();
}

class _InitialLoadingPageState extends State<InitialLoadingPage> {
  verify_device() async {
    var deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo;
    androidDeviceInfo = await deviceInfo.androidInfo;
    String device_identifier = androidDeviceInfo.androidId;
    ResponseWithMsg response_with_msg =
        await HttpService().verify_device(device_id: device_identifier);
    setState(() {
      _verification = true;
      _response = response_with_msg.msg;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => verify_device(),
    );
  }

  bool _verification = false;
  String _response;

  @override
  Widget build(BuildContext context) {
    if (_verification) {
      if (_response != 'ERROR') {
        if (_response == 'NON') {
          return SignInPromptPage();
        } else
          print("$_response is the response from the server");
        return Operator(username: _response, forward: true);
      } else {
        return Text('ERROR');
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
