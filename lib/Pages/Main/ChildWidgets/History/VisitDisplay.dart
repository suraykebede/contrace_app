import './Pages/VisitDetail.dart';
//import 'package:contact_tracer/Constants/Colors.dart';
import 'package:flutter/material.dart';

class VisitDisplay extends StatelessWidget {
  Color app_current_background;
  Color app_current_text;
  int time_entered;
  int time_exited;
  String venue_name;
  double venue_latitude;
  double venue_longitude;
  bool lang;

  VisitDisplay(
      {this.lang,
      this.app_current_background,
      this.app_current_text,
      this.time_entered,
      this.time_exited,
      this.venue_latitude,
      this.venue_longitude,
      this.venue_name});

  @override
  Widget build(BuildContext context) {
    DateTime enter = DateTime.fromMillisecondsSinceEpoch(this.time_entered);
    DateTime exit = DateTime.fromMillisecondsSinceEpoch(this.time_exited);

    return Column(
      children: [
        ListTile(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VisitDetail(
                          lang: this.lang,
                          venue_name: this.venue_name,
                          app_current_background: this.app_current_background,
                          app_current_text: this.app_current_text,
                          latitude: this.venue_latitude,
                          longitude: this.venue_longitude,
                          time_entered: this.time_entered,
                          time_exited: this.time_exited,
                        )))
          },
          leading: CircleAvatar(
            backgroundColor: this.app_current_background,
            child: Icon(
              Icons.location_on,
              color: this.app_current_text,
              size: 30,
            ),
          ),
          title: Text(this.venue_name,
              style: TextStyle(color: app_current_background)),
          subtitle: Text(
              "${enter.hour.toString()}:${enter.minute.toString()} to ${exit.hour.toString()}:${exit.minute.toString()} ",
              style: TextStyle(color: app_current_background)),
          trailing: Text(
              "${exit.day.toString()}/${exit.month.toString()}/${exit.year.toString()}",
              style: TextStyle(color: app_current_background)),
        ),
        Divider(
          color: Colors.white,
        )
      ],
    );
  }
}
