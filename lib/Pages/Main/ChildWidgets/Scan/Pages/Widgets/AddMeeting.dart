import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:latlong/latlong.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Objects/meeting_object.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';

class AddMeeting extends StatefulWidget {
  String username_one;
  String username_two;
  bool lang;
  Color app_current_background;
  Color app_current_text;

  AddMeeting(
      {this.username_one,
      this.username_two,
      this.lang,
      this.app_current_background,
      this.app_current_text});

  @override
  _AddMeetingState createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
  saving_meeting() async {
    double meeting_latitude;
    double meeting_longitude;
    Position position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    meeting_latitude = position.latitude;
    meeting_longitude = position.longitude;
    Meeting meeting = new Meeting(
        meeting_latitude: meeting_latitude,
        meeting_longitude: meeting_longitude,
        username_one: widget.username_one,
        username_two: widget.username_two);

    ResponseWithMsg res =
        await HttpService().add_meeting(meeting_object: meeting);

    setState(() {
      saving = false;
      server_response = res.msg;
    });
  }

  bool saving = true;
  String server_response;

  void initState() {
    super.initState();
    saving_meeting();
  }

  @override
  Widget build(BuildContext context) {
    if (saving) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      String message;
      if (server_response == 'MEETING_SAVED') {
        if (widget.lang) {
          message = 'Meeting has been saved';
        } else {
          message = "ግንኙንቱ ተመዝግቧል";
        }
      } else {
        if (widget.lang) {
          message = 'Please enable your internet connection';
        } else {
          message = 'እባክዎ የበይነመረብ ግንኙነትዎን ያንቁ';
        }
      }
      return Center(
        child: Text(
          message,
          style: TextStyle(fontSize: 20),
        ),
      );
    }
  }
}
