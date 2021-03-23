import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:latlong/latlong.dart';
import 'package:trace_et/Pages/Main/ChildWidgets/History/Widgets/image.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:trace_et/Connectivity/Objects/change_coords_object.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import '../../../Utilities/show_messages.dart';

class Account extends StatefulWidget {
  Color app_current_text;
  Color app_current_background;
  String username;
  bool lang;

  Account(
      {this.app_current_background,
      this.app_current_text,
      this.username,
      this.lang});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  double latitude;
  double longitude;
  bool loading_map = true;

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
                    color: widget.app_current_background,
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
            widget.lang ? 'Loading Map' : 'ካርታ በመጫን ላይ ነው',
            style:
                TextStyle(color: widget.app_current_background, fontSize: 25),
          )
        ],
      ),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _getCurrentLocation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: loading_map
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_forward_ios),
              backgroundColor: widget.app_current_background,
              onPressed: () async {
                ChangeCoordsObject changeCoordsObject = new ChangeCoordsObject(
                    username: widget.username,
                    new_latitude: latitude,
                    new_longitude: longitude);
                ResponseWithMsg res =
                    await HttpService().change_user_coords(changeCoordsObject);
                String msg = res.msg;
                String response;
                if (msg == 'COORDINATES_CHANGED') {
                  if (widget.lang) {
                    response = 'Coordinates changed';
                  } else {
                    response = 'ቦታ ተቀይሯል';
                  }
                } else {
                  if (widget.lang) {
                    response = 'Please enable your internet';
                  } else {
                    response = 'እባክዎን በይነመረብዎን ያንቁ';
                  }
                }
                ShowMessage(context: context, msg: response);
              },
            ),
      appBar: AppBar(
        backgroundColor: widget.app_current_background,
        leading: Icon(Icons.location_searching),
        centerTitle: true,
        title: Text(widget.lang ? 'Home Coordinates' : 'የመኖሪያ ቦታ'),
        actions: [
          UserImage(
            on_list: false,
            username: widget.username,
          )
        ],
      ),
      body: loading_map ? during_loading() : map(),
    );
  }
}
