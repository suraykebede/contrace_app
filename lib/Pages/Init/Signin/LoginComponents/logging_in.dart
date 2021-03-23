import 'package:flutter/material.dart';
import 'package:trace_et/Data/Constants/Colors/Init/header_colors.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Objects/login_auth_object.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Pages/Main/Operator.dart';

class LoggingIn extends StatefulWidget {
  String Username;
  String Password;
  Function try_again;

  LoggingIn({this.Username, this.Password, this.try_again});

  @override
  _LoggingInState createState() => _LoggingInState();
}

class _LoggingInState extends State<LoggingIn> {
  start_auth() async {
    LoginAuthObject loginAuthObject =
        LoginAuthObject(Username: widget.Username, Password: widget.Password);
    ResponseWithMsg response_with_msg =
        await HttpService().auth_user(my_login_auth_object: loginAuthObject);
    print(response_with_msg.msg);
    _result_from_request = response_with_msg.msg;
    setState(() {
      _initiating = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => start_auth(),
    );
  }

  bool _initiating = true;
  String _result_from_request = '';

  @override
  Widget build(BuildContext context) {
    if (_initiating) {
      return Container(
        padding: EdgeInsets.fromLTRB(
            0, screenHeightExcludingToolbar(context, dividedBy: 3.25), 0, 0),
        height: screenHeightExcludingToolbar(context, dividedBy: 1.25),
        child: Column(
          children: [
            CircularProgressIndicator(
              backgroundColor: header_text_color,
            ),
            SizedBox(
              height: screenHeightExcludingToolbar(context, dividedBy: 15),
            ),
            Text(
              'Logging in',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(
            0, screenHeightExcludingToolbar(context, dividedBy: 4.25), 0, 0),
        height: screenHeightExcludingToolbar(context, dividedBy: 2.25),
        child: Column(
          children: [
            _result_from_request == 'AUTHORIZED'
                ? Icon(Icons.check)
                : Icon(Icons.close),
            SizedBox(
              height: screenHeightExcludingToolbar(context, dividedBy: 15),
            ),
            Text(
              _result_from_request == 'AUTHORIZED'
                  ? 'Good to go'
                  : 'Incorrect Credentials',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: screenHeightExcludingToolbar(context, dividedBy: 15)),
            _result_from_request == 'AUTHORIZED'
                ? RaisedButton.icon(
                    onPressed: () {
                      print('username from form ${widget.Username}');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Operator(
                                    username: widget.Username,
                                    forward: false,
                                  )));
                    },
                    icon: Icon(Icons.arrow_forward_ios),
                    label: Text('Continue'))
                : RaisedButton.icon(
                    onPressed: () {
                      widget.try_again();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    label: Text('Try again'),
                  )
          ],
        ),
      );
    }
  }
}
