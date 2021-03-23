import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';

import './VisitDisplay.dart';
import 'package:flutter/material.dart';
import '../../../../Connectivity/Objects/visit_from_dbase.dart';

class VisitList extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String username;
  bool lang;

  VisitList(
      {this.app_current_background,
      this.app_current_text,
      this.username,
      this.lang})
      : super();
  @override
  _VisitListState createState() => _VisitListState();
}

class _VisitListState extends State<VisitList> {
  List<VisitFromDBase> _visits = List<VisitFromDBase>();
  bool is_loading = true;

  get_visits() async {
    // _visits.clear();
    List<VisitFromDBase> list =
        await HttpService().get_visits(username: widget.username);
    setState(() {
      _visits.addAll(list);
      is_loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    get_visits();
  }

  Widget after_loading() {
    if (_visits.length == 0) {
      return Center(
        child: Text(
          widget.lang ? 'No Visits' : 'ጉብኝቶች የሉም',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return VisitDisplay(
            lang: widget.lang,
            time_entered: _visits[index].time_entered,
            time_exited: _visits[index].time_exited,
            venue_latitude: _visits[index].venue_latitude,
            venue_longitude: _visits[index].venue_longitude,
            venue_name: _visits[index].venue_name,
            app_current_background: widget.app_current_background,
            app_current_text: widget.app_current_text,
          );
        },
        itemCount: _visits.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.app_current_text,
        child: is_loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : after_loading());
  }
}
