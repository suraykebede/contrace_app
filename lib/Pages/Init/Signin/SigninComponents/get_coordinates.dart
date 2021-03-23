import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
//import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:trace_et/Data/Constants/Colors/Init/header_colors.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'package:trace_et/Pages/Init/Signin/SigninComponents/add_user.dart';

class GetCoordinates extends StatefulWidget {
  File clipped_image;
  String first_name;
  String last_name;
  String username;
  String password;
  String phone_number;
  String email;
  int age;
  String gender;

  GetCoordinates(
      {this.clipped_image,
      this.email,
      this.first_name,
      this.last_name,
      this.password,
      this.phone_number,
      this.username,
      this.gender,
      this.age});

  @override
  _GetCoordinatesState createState() => _GetCoordinatesState();
}

class _GetCoordinatesState extends State<GetCoordinates> {
  double latitude;
  double longitude;
  bool loading_map = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _getCurrentLocation(),
    );
  }

  void _getCurrentLocation() async {
    print('getting location');
    Position position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(
        'latitude ${position.latitude.toString()} longitude ${position.longitude.toString()}');

    this.setState(() {
      loading_map = false;
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  Widget map() {
    return Container(
      height: screenHeightExcludingToolbar(context, dividedBy: 1),
      child: new FlutterMap(
        options: new MapOptions(
            center: new LatLng(latitude, longitude),
            zoom: 16,
            onPositionChanged: (mapPosition, boolValue) {
              if (boolValue) {
                this.setState(() {
                  LatLng moved = mapPosition.center;
                  latitude = moved.latitude;
                  longitude = moved.longitude;
                });
              }
            }),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 110.0,
                height: 110.0,
                point: new LatLng(latitude, longitude),
                builder: (ctx) => new Container(
                  child: Icon(
                    Icons.place,
                    color: header_text_color,
                    size: 60,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget during_loading() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(screenWidth(context, dividedBy: 20),
          screenHeightExcludingToolbar(context, dividedBy: 3), 0, 0),
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: screenHeightExcludingToolbar(context, dividedBy: 20),
          ),
          Text(
            'Loading Map',
            style: TextStyle(color: header_text_color, fontSize: 25),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: loading_map
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_forward_ios),
              backgroundColor: header_text_color,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddUser(
                              age: widget.age,
                              email: widget.email,
                              first_name: widget.first_name,
                              last_name: widget.last_name,
                              gender: widget.gender,
                              home_latitude: latitude,
                              home_longitude: longitude,
                              image: widget.clipped_image,
                              password: widget.password,
                              phone_number: widget.phone_number,
                              username: widget.username,
                            )));
              },
            ),
      appBar: AppBar(
        backgroundColor: header_text_color,
        title: Text("Get home coordinates"),
      ),
      body: loading_map ? during_loading() : map(),
    );
  }
}
