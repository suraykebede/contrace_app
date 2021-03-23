import '../Account.dart';
import '../History.dart';
import '../Notificaitons.dart';
import '../Scan.dart';
import '../Settings.dart';
import '../Venues.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Function to_dark;
  Function to_light;
  Function switcher;
  bool lang;
  Color app_current_background;
  Color app_current_text;
  String username;

  Home(
      {this.username,
      this.to_dark,
      this.to_light,
      this.app_current_background,
      this.app_current_text,
      this.lang,
      this.switcher})
      : super();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      Notifications(
        lang: widget.lang,
        username: widget.username,
        app_current_text: widget.app_current_text,
        app_current_background: widget.app_current_background,
      ),
      Scan(
          lang: widget.lang,
          username: widget.username,
          app_current_text: widget.app_current_text,
          app_current_background: widget.app_current_background),
      History(
          lang: widget.lang,
          username: widget.username,
          app_current_text: widget.app_current_text,
          app_current_background: widget.app_current_background),
      VenueOperator(
          lang: widget.lang,
          username: widget.username,
          app_current_text: widget.app_current_text,
          app_current_background: widget.app_current_background),
      Account(
        lang: widget.lang,
        app_current_text: widget.app_current_text,
        app_current_background: widget.app_current_background,
        username: widget.username,
      ),
      Settings(
          lang: widget.lang,
          switcher: widget.switcher,
          to_dark: widget.to_dark,
          to_light: widget.to_light,
          app_current_text: widget.app_current_text,
          app_current_background: widget.app_current_background),
    ];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.notification_important,
                size: 30,
                color: widget.app_current_background,
              ),
              title: Text("-")),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.stay_current_portrait,
              size: 30,
              color: widget.app_current_background,
            ),
            title: Text("-"),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                size: 30,
                color: widget.app_current_background,
              ),
              title: Text("-")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.place,
                size: 30,
                color: widget.app_current_background,
              ),
              title: Text("-")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
                color: widget.app_current_background,
              ),
              title: Text("-")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 30,
                color: widget.app_current_background,
              ),
              title: Text("-")),
        ],
      ),
    );
  }
}
