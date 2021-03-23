import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'package:trace_et/Pages/Main/ChildWidgets/Venue/loading_notifications.dart';
import '../../../../Connectivity/Objects/notification_object.dart';
import '../../ChildWidgets/Notification/Notification.dart' as VenueNotification;

class VenueNotifications extends StatefulWidget {
  String venue;
  Color app_current_background;
  Color app_current_text;
  bool lang;
  VenueNotifications(
      {this.venue,
      this.app_current_background,
      this.app_current_text,
      this.lang});

  @override
  _VenueNotificationsState createState() => _VenueNotificationsState();
}

class _VenueNotificationsState extends State<VenueNotifications> {
  bool loading = true;
  List<NotificationFromDBase> _notificationFromDBase =
      List<NotificationFromDBase>();

  Widget after_loading() {
    if (_notificationFromDBase.length == 0) {
      return ListTile(
        leading: CircleAvatar(child: Icon(Icons.notifications_off)),
        title: Text(
            widget.lang ? 'No notifications yet' : 'እስካሁን ምንም ማሳወቂያዎች የሉም'),
        subtitle: Text(widget.lang
            ? 'Venue related notifications will appear here'
            : 'ከቦታው ጋር የተያያዙ ማሳወቂያዎች እዚህ ይታያሉ'),
      );
    } else {
      return Container(
          height: screenHeightExcludingToolbar(context, dividedBy: 2.5),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return VenueNotification.Notification(
                app_current_background: widget.app_current_background,
                app_current_text: widget.app_current_text,
                msg: _notificationFromDBase[index].msg,
                time: _notificationFromDBase[index].time,
                type: _notificationFromDBase[index].type,
              );
            },
            itemCount: _notificationFromDBase.length,
          ));
    }
  }

  get_notifications() async {
    List<NotificationFromDBase> notificationFromDBase =
        await HttpService().get_Venue_notifications(venue: widget.venue);
    _notificationFromDBase.addAll(notificationFromDBase);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => get_notifications(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return LoadingNotifications();
    } else {
      return after_loading();
    }
  }
}
