import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';

class UserImage extends StatefulWidget {
  String username;
  bool on_list;

  UserImage({this.username, this.on_list});

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  bool is_loading = false;
  String image_url = "";

  get_image() async {
    ResponseWithMsg res = await HttpService().image_getter(widget.username);
    this.setState(() {
      print('username ${widget.username}\'s image url is ${res.msg}  ');
      image_url = res.msg;
      is_loading = false;
    });
  }

  Widget circle_image() {
    if (widget.on_list) {
      print('this is the url: ${this.image_url}');
      return CircleAvatar(
        backgroundImage: NetworkImage(image_url),
        radius: screenHeightExcludingToolbar(context, dividedBy: 25),
      );
    } else {
      return CircleAvatar(
        radius: screenHeight(context, dividedBy: 20),
        backgroundImage: NetworkImage(image_url),
      );
    }
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
    return is_loading
        ? CircleAvatar(
            child: Icon(Icons.person_outline),
            radius: screenHeightExcludingToolbar(context, dividedBy: 40),
          )
        : circle_image();
  }
}
