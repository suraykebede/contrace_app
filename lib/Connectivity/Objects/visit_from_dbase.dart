class VisitFromDBase {
  String venue_name;
  double venue_longitude;
  double venue_latitude;
  int time_entered;
  int time_exited;

  VisitFromDBase.fromJson(Map<String, dynamic> json) {
    venue_latitude = double.parse(json['venue_latitude'].toString());
    venue_longitude = double.parse(json['venue_longitude'].toString());
    time_entered = json['time_entered'];
    time_exited = json['time_exited'];
    venue_name = json['venue_name'];
  }
}
