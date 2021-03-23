import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';

class ScannedUserImage extends StatefulWidget {
  String username;

  ScannedUserImage({this.username}) : super();

  @override
  _ScannedUserImageState createState() => _ScannedUserImageState();
}

class _ScannedUserImageState extends State<ScannedUserImage> {
  bool getting_image = true;
  String image_url;

  get_image() async {
    ResponseWithMsg res = await HttpService().image_getter(widget.username);
    this.setState(() {
      image_url = res.msg;
      getting_image = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => get_image(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!this.getting_image) {
      print('the url ${this.image_url}');
    }
    return getting_image
        ? CircleAvatar(
            radius: screenHeightExcludingToolbar(context, dividedBy: 12),
            child: Icon(
              Icons.person_outline,
              size: screenHeightExcludingToolbar(context, dividedBy: 8),
            ),
          )
        : CircleAvatar(
            radius: screenHeightExcludingToolbar(context, dividedBy: 12),
            backgroundImage: NetworkImage(image_url),
          );
  }
}
