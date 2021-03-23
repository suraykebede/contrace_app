import '../ChildWidgets/History/MeetingsList.dart';
import '../ChildWidgets/History/VisitsList.dart';
//import 'package:contact_tracer/Constants/Colors.dart';
import '../../../Data/Constants/Sizes.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String username;
  bool lang;

  History(
      {this.app_current_background,
      this.app_current_text,
      this.username,
      this.lang})
      : super();

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                body: Column(
              children: [
                Container(
                    color: widget.app_current_text,
                    width: screenWidth(context, dividedBy: 1),
                    height: screenHeight(context, dividedBy: 7),
                    child: TabBar(
                        indicatorColor: widget.app_current_background,
                        tabs: [
                          Tab(
                            icon: Icon(
                              Icons.people,
                              color: widget.app_current_background,
                              size: screenHeight(context, dividedBy: 15),
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.place,
                              color: widget.app_current_background,
                              size: screenHeight(context, dividedBy: 15),
                            ),
                          )
                        ])),
                Container(
                    height: screenHeight(context, dividedBy: 1.42),
                    child: TabBarView(children: [
                      MeetingsList(
                        lang: widget.lang,
                        username: widget.username,
                        app_current_background: widget.app_current_background,
                        app_current_text: widget.app_current_text,
                      ),
                      VisitList(
                        lang: widget.lang,
                        username: widget.username,
                        app_current_background: widget.app_current_background,
                        app_current_text: widget.app_current_text,
                      )
                    ])),
              ],
            ))));
  }
}
