import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Objects/meeting_from_dbase.dart';

import '../../ChildWidgets/History/MeetingDisplay.dart';
//import 'package:contact_tracer/Constants/Colors.dart';
import 'package:flutter/material.dart';

class MeetingsList extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String username;
  bool lang;

  MeetingsList(
      {this.app_current_background,
      this.app_current_text,
      this.username,
      this.lang})
      : super();

  @override
  _MeetingsListState createState() => _MeetingsListState();
}

class _MeetingsListState extends State<MeetingsList> {
  List<MeetingFromDbase> _meetings = List<MeetingFromDbase>();

  bool is_loading = true;

  get_meetings() async {
    _meetings.clear();
    List<MeetingFromDbase> list =
        await HttpService().get_meetings(username: widget.username);
    setState(() {
      _meetings.addAll(list);
      is_loading = false;
    });
  }

  Widget after_loading({BuildContext context}) {
    if (_meetings.length == 0) {
      return Center(
        child: Text(
          widget.lang ? 'No Meetings' : 'ግንኙነቶች የሉም',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          print('meeting index $index');
          if (_meetings[index].venue != null) {
            return MeetingDisplay(
              lang: widget.lang,
              meeting: _meetings[index],
              app_current_background: widget.app_current_background,
              app_current_text: widget.app_current_text,
            );
          } else {
            return Container();
          }
        },
        itemCount: _meetings.length,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    get_meetings();
  }

  @override
  Widget build(BuildContext context) {
    return is_loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : after_loading();
  }
}
