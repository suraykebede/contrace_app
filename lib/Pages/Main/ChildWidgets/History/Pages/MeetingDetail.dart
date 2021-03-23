//import 'package:contact_tracer/Constants/Colors.dart';
import 'package:trace_et/Connectivity/Objects/meeting_from_dbase.dart';
import 'package:trace_et/Pages/Main/ChildWidgets/History/Widgets/image.dart';

import '../../../../../Data/Constants/Sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MeetingDetail extends StatelessWidget {
  final int heroTag;
  Color app_current_background;
  Color app_current_text;
  MeetingFromDbase meeting;
  bool lang;

  MeetingDetail(
      {this.heroTag,
      this.lang,
      this.app_current_background,
      this.app_current_text,
      this.meeting})
      : super();

  @override
  Widget build(BuildContext context) {
    print(
        'Meeting place -------------------- ${meeting.venue} ----------------------------');
    DateTime time = DateTime.fromMillisecondsSinceEpoch(meeting.time);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.app_current_text,
        leading: BackButton(
          color: app_current_background,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Hero(
            tag: heroTag,
            child: UserImage(
              username: meeting.met_person,
              on_list: false,
            ),
          ),
          SizedBox(
            width: screenWidth(context, dividedBy: 15),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                meeting.met_person,
                style: TextStyle(fontSize: 20, color: app_current_background),
              )),
          SizedBox(
            width: screenWidth(context, dividedBy: 4),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
              height: screenHeightExcludingToolbar(context, dividedBy: 2),
              color: this.app_current_background,
              child: new FlutterMap(
                options: new MapOptions(
                  center: new LatLng(
                      meeting.meeting_latitude, meeting.meeting_longitude),
                  zoom: 13.0,
                ),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  new MarkerLayerOptions(
                    markers: [
                      new Marker(
                        width: 80.0,
                        height: 80.0,
                        point: new LatLng(meeting.meeting_latitude,
                            meeting.meeting_longitude),
                        builder: (ctx) => new Container(
                          child: Icon(
                            Icons.place,
                            color: this.app_current_background,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
            decoration: BoxDecoration(
              color: this.app_current_text,
            ),
            height: screenHeightExcludingToolbar(context, dividedBy: 2),
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: app_current_background,
                    child: Icon(
                      Icons.place,
                      color: this.app_current_text,
                    ),
                  ),
                  title: Text(this.lang ? 'Venue' : 'ቦታ'),
                  subtitle: Text(meeting.venue == "NON"
                      ? this.lang ? 'Not in a venue' : 'በሌላ ቦታ'
                      : meeting.venue),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: this.app_current_background,
                    child: Icon(
                      Icons.date_range,
                      color: this.app_current_text,
                    ),
                  ),
                  title: Text(
                      '${time.day.toString()}/${time.month.toString()}/${time.year.toString()}'),
                  subtitle:
                      Text('${time.hour.toString()}:${time.minute.toString()}'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
