import '../../ChildWidgets/Scan/Pages/SeeCoordinates.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:latlong/latlong.dart';

class MeetingCoordinates extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;

  MeetingCoordinates({this.app_current_background, this.app_current_text})
      : super();

  @override
  _MeetingCoordinatesState createState() => _MeetingCoordinatesState();
}

class _MeetingCoordinatesState extends State<MeetingCoordinates> {
  bool fetchingLocation = true;
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      fetchingLocation = false;
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fetchingLocation) {
      return ListTile(
        leading: Icon(Icons.scatter_plot),
        title: Text('Coordinates'),
        subtitle: Text('Getting coordinates'),
      );
    } else {
      LatLng positionOfInterest = new LatLng(latitude, longitude);
      return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeeCoordinates(
                        positionOfInterest: positionOfInterest,
                        app_current_background: widget.app_current_background,
                        app_current_text: widget.app_current_text,
                      )));
        },
        leading: Icon(Icons.scatter_plot),
        title: Text('Tap to see coordinates'),
        subtitle: Text('Lat: ' +
            positionOfInterest.latitude.toString() +
            ' Lng: ' +
            positionOfInterest.longitude.toString()),
      );
    }
  }
}
