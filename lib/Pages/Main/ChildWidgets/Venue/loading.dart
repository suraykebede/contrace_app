import 'package:flutter/material.dart';

class LoadingVenue extends StatefulWidget {
  Color app_current_text;
  Color app_current_background;
  bool lang;

  LoadingVenue({this.app_current_background, this.app_current_text, this.lang});

  @override
  _LoadingVenueState createState() => _LoadingVenueState();
}

class _LoadingVenueState extends State<LoadingVenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.app_current_background,
        title: Text(
          widget.lang
              ? 'Getting Your Venue Information . . .'
              : 'የሚያስተዳድሩትን ቦታ . . .',
          style: TextStyle(color: widget.app_current_text),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
