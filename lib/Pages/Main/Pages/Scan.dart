import '../ChildWidgets/Scan/Pages/GetScanned.dart';
import '../ChildWidgets/Scan/Pages/ScanPhone.dart';
//import 'package:contact_tracer/Constants/Colors.dart';
import 'package:flutter/material.dart';

class Scan extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String username;
  bool lang;
  Scan(
      {this.app_current_background,
      this.app_current_text,
      this.username,
      this.lang})
      : super();

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    String scan_text;

    if (widget.lang) {
      scan_text = 'Scan options';
    } else {
      scan_text = 'የማንበቢያ አማራጮች';
    }
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.album),
            backgroundColor: widget.app_current_background,
            centerTitle: true,
            title: Text(scan_text),
            bottom: TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                  icon: Icon(
                    Icons.add_to_home_screen,
                    color: Colors.yellow,
                  ),
                  text: widget.lang ? 'Scan' : 'አንብብ'),
              Tab(
                icon: (Icon(
                  Icons.mobile_screen_share,
                  color: Colors.yellow,
                )),
                text: widget.lang ? 'Get Scanned' : 'ተነበብ',
              )
            ]),
          ),
          body: TabBarView(children: [
            ScanPhone(
                lang: widget.lang,
                app_current_background: widget.app_current_background,
                app_current_text: widget.app_current_text,
                username: widget.username),
            GetScanned(
              app_current_background: widget.app_current_background,
              app_current_text: widget.app_current_text,
              username: widget.username,
            )
          ]),
        ));
  }
}
