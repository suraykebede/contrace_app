//import 'package:contact_tracer/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Data/Constants/Colors/App/dark_variants.dart';
import '../../../Utilities/show_messages.dart';

class Settings extends StatefulWidget {
  Function to_dark;
  Function to_light;
  Function switcher;
  bool lang;
  Color app_current_text;
  Color app_current_background;

  Settings(
      {this.to_dark,
      this.to_light,
      this.app_current_background,
      this.app_current_text,
      this.lang,
      this.switcher})
      : super();

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.settings),
        title: Text(widget.lang ? "Settings" : "ማስተካከያዎች"),
        backgroundColor: widget.app_current_background,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              widget.switcher();
            },
            leading: CircleAvatar(
              backgroundColor: widget.app_current_background,
              child: Icon(Icons.speaker_notes),
            ),
            title: Text(widget.lang ? 'English' : "አማርኛ"),
            subtitle: Text(
                widget.lang ? 'ወደ አማርኛ ለመቀየር ይጫኑ' : "Tap to switch to English"),
          ),
          ListTile(
            onTap: () {
              print('changing theme');
              if (widget.app_current_background == app_dark_background) {
                widget.to_light();
              } else {
                widget.to_dark();
              }
              print('changed');
            },
            leading: CircleAvatar(
              backgroundColor: widget.app_current_background,
              child: Icon(Icons.invert_colors),
            ),
            title: Text(widget.app_current_background == app_dark_background
                ? widget.lang ? 'On dark mode' : 'በጭለማ ሞድ'
                : widget.lang ? 'On light mode' : 'በብርሃን ሞድ'),
            subtitle: Text(widget.app_current_background == app_dark_background
                ? widget.lang ? 'tap to change to light mode' : 'ወደ ብርሃን ሞድ'
                : widget.lang ? 'tap to change to dark mode' : 'ወደ ጭለማ ሞድ'),
          ),
          ListTile(
            onTap: () async {
              ShowMessage(context: context, msg: 'Logging out and exiting');
              ResponseWithMsg res = await HttpService().logout();
              String response = res.msg;
              if (response != 'ERROR') {
                SystemNavigator.pop();
              } else {
                ShowMessage(context: context, msg: 'Unable to log out');
              }
            },
            leading: CircleAvatar(
              backgroundColor: widget.app_current_background,
              child: Icon(Icons.power_settings_new),
            ),
            title: Text(widget.lang ? 'Log out' : 'ውጣ'),
            subtitle: Text(widget.lang
                ? 'log out and exit application'
                : 'ከአካውንት አስወጣ እና ዝጋው'),
          ),
        ],
      ),
    );
  }
}
