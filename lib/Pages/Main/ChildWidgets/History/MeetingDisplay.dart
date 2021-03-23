import 'package:trace_et/Connectivity/Objects/meeting_from_dbase.dart';
import '../../ChildWidgets/History/Pages/MeetingDetail.dart';
import '../../Operations/heroes.dart';
import 'package:flutter/material.dart';
import './Widgets/full_name.dart';

class MeetingDisplay extends StatelessWidget {
  Color app_current_background;
  Color app_current_text;
  MeetingFromDbase meeting;
  bool lang;

  MeetingDisplay(
      {this.app_current_background,
      this.app_current_text,
      this.meeting,
      this.lang});

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(meeting.time);
    int heroTag = myHero();
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MeetingDetail(
                          lang: this.lang,
                          app_current_background: this.app_current_background,
                          app_current_text: this.app_current_text,
                          heroTag: heroTag,
                          meeting: this.meeting,
                        )));
          },
          leading: Hero(
              tag: heroTag,
              child: CircleAvatar(
                child: Icon(Icons.person_outline, color: this.app_current_text),
                backgroundColor: this.app_current_background,
              )),
          title: FullName(
            app_background_color: this.app_current_background,
            username: meeting.met_person,
          ),
          subtitle: Text(
            '${time.day.toString()}/${time.month.toString()}/${time.year.toString()}',
            style: TextStyle(color: this.app_current_background),
          ),
          trailing: Text(
            this.lang ? 'Tap for details' : 'ለዝርዝር ይጫኑ',
            style: TextStyle(color: this.app_current_background, fontSize: 15),
          ),
        ),
        Divider(
          color: this.app_current_background,
        )
      ],
    );
  }
}
