import 'package:flutter/material.dart';
import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';
import '../ChildWidgets/Venue/loading.dart';
import '../ChildWidgets/Venue/no_venue.dart';
import '../ChildWidgets/Venue/venues.dart';
import '../../../Connectivity/Objects/venue_information_object.dart';

class VenueOperator extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String username;
  bool lang;

  VenueOperator(
      {this.username,
      this.app_current_background,
      this.app_current_text,
      this.lang});

  @override
  _VenueOperatorState createState() => _VenueOperatorState();
}

class _VenueOperatorState extends State<VenueOperator> {
  bool loading = true;
  bool has_venue = true;
  VenueInformationObject _venueInformationObject;

  get_venue_info() async {
    VenueInformationObject venueInformationObject =
        await HttpService().get_venue_information(username: widget.username);
    print('object from database' + venueInformationObject.attendees.toString());
    _venueInformationObject = venueInformationObject;
    if (_venueInformationObject.attendees == -1) {
      setState(() {
        loading = false;
        has_venue = false;
      });
    } else {
      setState(() {
        loading = false;
        has_venue = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => get_venue_info(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return LoadingVenue(
        lang: widget.lang,
        app_current_background: widget.app_current_background,
        app_current_text: widget.app_current_text,
      );
    } else {
      print('about to send to screen ' +
          _venueInformationObject.attendees.toString());
      if (has_venue) {
        return Venues(
          lang: widget.lang,
          app_current_background: widget.app_current_background,
          app_current_text: widget.app_current_text,
          attendees: _venueInformationObject.attendees,
          venue: _venueInformationObject.venue,
          venue_name: _venueInformationObject.venue_name,
        );
      } else {
        return NoVenue(lang: widget.lang);
      }
    }
  }
}
