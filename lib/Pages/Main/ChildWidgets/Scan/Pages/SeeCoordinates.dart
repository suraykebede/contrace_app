//import 'package:contact_tracer/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class SeeCoordinates extends StatelessWidget {
  Color app_current_background;
  Color app_current_text;
  final LatLng positionOfInterest;

  SeeCoordinates(
      {this.positionOfInterest,
      this.app_current_background,
      this.app_current_text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: this.app_current_background,
          centerTitle: true,
          title: Text('You are here'),
        ),
        body: FlutterMap(
          options: new MapOptions(
            center: new LatLng(
                positionOfInterest.latitude, positionOfInterest.longitude),
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
                  point: new LatLng(positionOfInterest.latitude,
                      positionOfInterest.longitude),
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
        ));
  }
}
