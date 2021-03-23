import '../../../ChildWidgets/Scan/MeetingCoordinates.dart';
//import 'package:contact_tracer/Constants/Colors.dart';
import '../../../../../Data/Constants/Sizes.dart';
import 'package:flutter/material.dart';
import './Widgets/GetFullName.dart';
import './Widgets/GetPhoneNumber.dart';
import './Widgets/ScannedUserImage.dart';
import './Widgets/AddMeeting.dart';

class ScannedMeeting extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String scanned_user;
  String username;
  bool lang;

  ScannedMeeting(
      {this.scanned_user,
      this.app_current_background,
      this.app_current_text,
      this.username,
      this.lang})
      : super();

  @override
  _ScannedMeetingState createState() => _ScannedMeetingState();
}

class _ScannedMeetingState extends State<ScannedMeeting> {
  bool saving_meeting = false;

  @override
  Widget build(BuildContext context) {
    // print("from info " + widget.scanned_user);
    //  print("Length: " + widget.scanned_user.length.toString());
    print(widget.scanned_user);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.lang ? 'Meeting' : 'ግንኙነቶች'),
        backgroundColor: widget.app_current_background,
        elevation: 0,
      ),
      body: saving_meeting
          ? AddMeeting(
              lang: widget.lang,
              app_current_background: widget.app_current_background,
              app_current_text: widget.app_current_text,
              username_two: widget.scanned_user,
              username_one: widget.username)
          : ListView(
              children: [
                Container(
                  color: widget.app_current_text,
                  width: screenWidth(context, dividedBy: 1),
                  height: screenHeight(context, dividedBy: 1.8),
                  padding: EdgeInsets.symmetric(
                      vertical:
                          screenHeightExcludingToolbar(context, dividedBy: 14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScannedUserImage(
                        username: widget.scanned_user,
                      ),
                      Text(
                        widget.scanned_user,
                        style: TextStyle(
                            color: widget.app_current_background,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenHeightExcludingToolbar(context,
                            dividedBy: 12),
                      ),
                      SizedBox(
                        height: screenHeightExcludingToolbar(context,
                            dividedBy: 40),
                      ),
                      GetFullName(
                        username: widget.scanned_user,
                        app_current_backround: widget.app_current_background,
                        app_current_text: widget.app_current_text,
                      ),
                      SizedBox(
                        height: screenHeightExcludingToolbar(context,
                            dividedBy: 40),
                      ),
                      GetPhoneNumber(
                        username: widget.scanned_user,
                        app_current_backround: widget.app_current_background,
                        app_current_text: widget.app_current_text,
                      ),
                    ],
                  ),
                ),
                MeetingCoordinates(
                  app_current_background: widget.app_current_background,
                  app_current_text: widget.app_current_text,
                )
              ],
            ),
      floatingActionButton: saving_meeting
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  saving_meeting = true;
                });
              },
              backgroundColor: widget.app_current_background,
              label: Text(
                widget.lang ? 'Save Meeting' : 'ግንኙነቶች መዝግብ',
                style: TextStyle(color: Colors.yellow),
              ),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.yellow,
              ),
            ),
    );
  }
}
