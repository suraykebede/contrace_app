class NotificationFromDBase {
  String msg;
  String type;
  int time;

  NotificationFromDBase.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    type = json['type'];
    time = json['time'];
  }
}
