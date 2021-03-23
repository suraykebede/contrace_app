//import 'package:contact_tracer/Constants/Colors.dart';
import '../../../../../Data/Constants/Sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class VisitDetail extends StatelessWidget {
  Color app_current_background;
  Color app_current_text;
  double latitude;
  double longitude;
  String venue_name;
  int time_entered;
  int time_exited;
  bool lang;

  VisitDetail(
      {this.app_current_background,
      this.app_current_text,
      this.latitude,
      this.longitude,
      this.venue_name,
      this.time_entered,
      this.time_exited,
      this.lang});

  final TextStyle infoTextStyle =
      new TextStyle(color: Colors.red, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    DateTime enter = DateTime.fromMillisecondsSinceEpoch(this.time_entered);
    DateTime exit = DateTime.fromMillisecondsSinceEpoch(this.time_exited);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: this.app_current_background,
        title: Text(
          this.venue_name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Container(
              height: screenHeightExcludingToolbar(context, dividedBy: 2),
              color: this.app_current_background,
              child: new FlutterMap(
                options: new MapOptions(
                  center: new LatLng(this.latitude, this.longitude),
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
                        point: new LatLng(this.latitude, this.longitude),
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
                border: Border(
                    top: BorderSide(
                        color: this.app_current_text,
                        width: screenHeightExcludingToolbar(context,
                            dividedBy: 80)))),
            height: screenHeightExcludingToolbar(context, dividedBy: 2),
            alignment: Alignment.center,
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: app_current_background,
                    child: Icon(
                      Icons.calendar_today,
                      color: this.app_current_text,
                    ),
                  ),
                  title: Text(
                      '${enter.day.toString()}/${enter.month.toString()}/${enter.year.toString()}'),
                  subtitle: Text(this.lang ? 'Date of visit' : 'የጉብኝት ቀን'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: app_current_background,
                    child: Icon(
                      Icons.access_time,
                      color: this.app_current_text,
                    ),
                  ),
                  title: Text(
                      '${enter.hour.toString()}:${enter.minute.toString()}'),
                  subtitle: Text(this.lang ? 'Entered on' : 'ገብቷል'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: app_current_background,
                    child: Icon(
                      Icons.access_time,
                      color: this.app_current_text,
                    ),
                  ),
                  title:
                      Text('${exit.hour.toString()}:${exit.minute.toString()}'),
                  subtitle: Text(this.lang ? 'Exited on' : 'ወጥቷል'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
