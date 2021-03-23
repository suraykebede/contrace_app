class MeetingFromDbase {
  String met_person;
  double meeting_latitude;
  double meeting_longitude;
  String venue;
  int time;

  MeetingFromDbase.fromJson(Map<String, dynamic> json) {
    if (json['meeting_latitude'].toString() != 'NON' ||
        json['meeting_longitude'].toString() != "NON") {
      meeting_latitude = double.parse(json['meeting_latitude']);
      meeting_longitude = double.parse(json['meeting_longitude']);
    }
    venue = json['venue'];
    time = json['time'];
    met_person = json['met_person'];
  }
}
