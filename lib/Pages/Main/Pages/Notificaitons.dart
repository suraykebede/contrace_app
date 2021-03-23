import 'package:flutter/material.dart';
import '../ChildWidgets/Notification/Notification.dart' as MyNotification;
import '../../../Connectivity/Objects/notification_object.dart';
import '../../../Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';

class Notifications extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String username;
  bool lang;

  Notifications(
      {this.app_current_background,
      this.app_current_text,
      this.username,
      this.lang});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationFromDBase> _notifications = List<NotificationFromDBase>();

  bool is_loading = true;

  get_notifications() async {
    _notifications.clear();
    List<NotificationFromDBase> list =
        await HttpService().get_notifications(username: widget.username);
    setState(() {
      _notifications.addAll(list);
      is_loading = false;
    });
  }

  Widget after_loading({BuildContext context}) {
    if (_notifications.length == 0) {
      return Center(
        child: Text(widget.lang ? 'No Notifications' : 'ማስታወሻ የለም'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          print('notification index $index');
          return MyNotification.Notification(
            time: _notifications[index].time,
            msg: _notifications[index].msg,
            type: _notifications[index].type,
            app_current_background: widget.app_current_background,
            app_current_text: widget.app_current_text,
          );
        },
        itemCount: _notifications.length,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    get_notifications();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: widget.app_current_text,
        centerTitle: true,
        title: Text(
          widget.lang ? 'Notifications' : 'ማስታወሻዎች',
          style: TextStyle(color: widget.app_current_background),
        ),
      ),
      body: is_loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : after_loading(),
    ));
  }
}
