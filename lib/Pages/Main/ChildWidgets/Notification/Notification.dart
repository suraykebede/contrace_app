import 'package:flutter/material.dart';

class Notification extends StatelessWidget {
  Color app_current_text;
  Color app_current_background;
  String type;
  String msg;
  int time;

  Notification(
      {this.app_current_background,
      this.app_current_text,
      this.time,
      this.msg,
      this.type});

  @override
  Widget build(BuildContext context) {
    DateTime notification_time = DateTime.fromMillisecondsSinceEpoch(time);
    String time_display =
        "${notification_time.day.toString()}/${notification_time.month.toString()}/${notification_time.year.toString()} at ${notification_time.hour.toString()}:${notification_time.minute.toString()}";
    return ListTile(
      leading: this.type == "info"
          ? Icon(
              Icons.notifications_active,
              color: app_current_background,
            )
          : Icon(
              Icons.notification_important,
              color: app_current_background,
            ),
      title: Text(time_display),
      subtitle: Text(msg),
    );
  }
}
