import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'package:trace_et/Utilities/show_messages.dart';
import './Widgets/AddVisit.dart';

class ScannedVisit extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String venue_name;
  String username;
  String venue;
  bool lang;

  ScannedVisit(
      {this.username,
      this.venue_name,
      this.app_current_background,
      this.app_current_text,
      this.venue,
      this.lang})
      : super();

  @override
  _ScannedVisitState createState() => _ScannedVisitState();
}

class _ScannedVisitState extends State<ScannedVisit> {
  bool getting_information = true;
  String status = 'Enter';
  bool sending_request = false;

  current_venue() async {
    ResponseWithMsg res =
        await HttpService().current_venue(username: widget.username);
    setState(() {
      String current = res.msg;
      if (current != 'ERROR') {
        if (current == "NON") {
          status = widget.lang ? 'Enter' : 'ግባ';
        } else {
          status = widget.lang ? 'Exit' : 'ውጣ';
        }
      }
      getting_information = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => current_venue(),
    );
  }

  Widget floater() {
    return getting_information
        ? FloatingActionButton.extended(
            isExtended: true,
            icon: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            label: Text(widget.lang ? 'Just a moment' : 'አንድ አፍታ'),
            onPressed: () => {
              ShowMessage(
                  context: context,
                  msg: widget.lang ? 'Just a moment' : 'አንድ አፍታ')
            },
            backgroundColor: widget.app_current_background,
          )
        : FloatingActionButton.extended(
            label: Text(status),
            isExtended: true,
            icon: Icon(Icons.my_location),
            onPressed: () {
              setState(() {
                sending_request = true;
              });
            },
            backgroundColor: widget.app_current_background,
          );
  }

  @override
  Widget build(BuildContext context) {
    DateTime d = DateTime.now();
    return Scaffold(
      floatingActionButton: sending_request ? null : floater(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.lang ? 'Visit' : 'ጉብኝት'),
        backgroundColor: widget.app_current_background,
        elevation: 0,
      ),
      body: sending_request
          ? AddVisit(
              lang: widget.lang,
              app_current_background: widget.app_current_background,
              app_current_text: widget.app_current_text,
              username: widget.username,
              venue: widget.venue,
            )
          : Container(
              child: ListView(
                children: [
                  Container(
                      width: screenWidth(context, dividedBy: 1),
                      height:
                          screenHeightExcludingToolbar(context, dividedBy: 2),
                      child: Card(
                          elevation: 3,
                          color: widget.app_current_text,
                          shadowColor: widget.app_current_background,
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(
                                  0,
                                  screenHeightExcludingToolbar(context,
                                      dividedBy: 15),
                                  0,
                                  0),
                              child: Column(
                                children: [
                                  Icon(Icons.location_on,
                                      color: widget.app_current_background,
                                      size: screenHeightExcludingToolbar(
                                          context,
                                          dividedBy: 8)),
                                  Text(
                                    widget.venue_name,
                                    style: TextStyle(
                                        color: widget.app_current_background,
                                        fontSize: screenHeightExcludingToolbar(
                                            context,
                                            dividedBy: 20)),
                                  ),
                                ],
                              )))),
                  ListTile(
                    title: Text(widget.lang
                        ? '${d.hour.toString()}:${d.minute.toString()}'
                        : 'ወደ ${d.hour.toString()}:${d.minute.toString()} ገደማ'),
                    leading: Icon(Icons.timelapse),
                  )
                ],
              ),
            ),
    );
  }
}
