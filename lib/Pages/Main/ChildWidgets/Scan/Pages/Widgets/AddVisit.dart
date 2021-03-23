import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Objects/visit_object.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';

class AddVisit extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String username;
  String venue;
  bool lang;

  AddVisit(
      {this.lang,
      this.app_current_background,
      this.app_current_text,
      this.username,
      this.venue});

  @override
  _AddVisitState createState() => _AddVisitState();
}

class _AddVisitState extends State<AddVisit> {
  bool sending_request = true;
  String response_message = "";

  current_venue() async {
    VisitObject v_object =
        VisitObject(username: widget.username, venue: widget.venue);
    ResponseWithMsg res = await HttpService().add_visit(visit_object: v_object);
    setState(() {
      sending_request = false;
      response_message = res.msg;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => current_venue(),
    );
  }

  @override
  Widget build(BuildContext context) {
    String message = "";
    if (!sending_request) {
      if (response_message == "VENUE_ENTERED") {
        if (widget.lang) {
          message = 'You have entered the venue';
        } else {
          message = "ቦታው ገብተዋል";
        }
      } else if (response_message == "VENUE_EXITED") {
        if (widget.lang) {
          message = 'You have exited the venue';
        } else {
          message = "ከቦታው ወጥተዋል";
        }
      } else {
        if (widget.lang) {
          message = "Please enable your internet connection";
        } else {
          message = 'እባክዎን የበይነመረብ ግንኙነትዎን ያንቁ';
        }
      }
    }
    return sending_request
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 20),
            ),
          );
  }
}
