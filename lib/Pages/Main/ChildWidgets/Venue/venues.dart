import 'package:flutter/material.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import './notifications.dart';
//import '../Constants/Colors.dart';

class Venues extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  int attendees;
  String venue_name;
  String venue;
  bool lang;

  Venues(
      {this.app_current_background,
      this.app_current_text,
      this.attendees,
      this.venue,
      this.venue_name,
      this.lang})
      : super();

  @override
  _VenuesState createState() => _VenuesState();
}

class _VenuesState extends State<Venues> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.app_current_background,
          leading: Icon(Icons.place),
          title: Text(
            widget.venue,
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0,
                  screenHeightExcludingToolbar(context, dividedBy: 20), 0, 0),
              child: Text(widget.venue_name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.app_current_background,
                    fontSize: 25,
                  )),
            ),
            SizedBox(
              height: screenHeightExcludingToolbar(context, dividedBy: 15),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: widget.app_current_background,
                child: Icon(Icons.people),
              ),
              title: Text(widget.lang
                  ? 'Current Attendees'
                  : 'በአሁኑ ሰዓት በዚያ ቦታ ያሉ ሰዎች ብዛት'),
              subtitle: Text(widget.attendees.toString()),
            ),
            SizedBox(
              height: screenHeightExcludingToolbar(context, dividedBy: 15),
            ),
            VenueNotifications(
                lang: widget.lang,
                venue: widget.venue,
                app_current_background: widget.app_current_background,
                app_current_text: widget.app_current_text)
          ],
        ),
      ),
    );
  }
}
