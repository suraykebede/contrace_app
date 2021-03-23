class VenueInformationObject {
  String venue;
  String venue_name;
  int attendees;

  VenueInformationObject.fromJson(Map<String, dynamic> json) {
    print('inside class creation' + json.toString());
    venue = json['venue'];
    venue_name = json['venue_name'];
    attendees = json['attendees'];
  }
}
