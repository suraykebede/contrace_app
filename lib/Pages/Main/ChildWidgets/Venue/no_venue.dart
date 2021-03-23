import 'package:flutter/material.dart';

class NoVenue extends StatelessWidget {
  Color app_current_text;
  Color app_current_background;
  bool lang;

  NoVenue({this.app_current_background, this.app_current_text, this.lang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: app_current_background,
        title: Text(this.lang ? 'No venue found' : 'ምንም አልተገኘም'),
        centerTitle: true,
      ),
      body: Center(
          child: Text(this.lang
              ? 'You are not a venue administrator'
              : 'የሚያስተዳድሩት ቦታ የለዎትም')),
    );
  }
}
