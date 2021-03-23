import 'package:trace_et/Pages/Main/Operations/getUserNameFromQrCode.dart';
import 'package:trace_et/Pages/Main/Operations/getVenueName.dart';

import '../../../ChildWidgets/Scan/Pages/ScannedMeeting.dart';
import '../../../ChildWidgets/Scan/Pages/ScannedVisit.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';

class ScanPhone extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String username;
  bool lang;

  ScanPhone(
      {this.app_current_background,
      this.app_current_text,
      this.username,
      this.lang})
      : super();

  @override
  _ScanPhoneState createState() => _ScanPhoneState();
}

class _ScanPhoneState extends State<ScanPhone> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton.icon(
            onPressed: () async {
              String scanning = await FlutterBarcodeScanner.scanBarcode(
                  "#000000", widget.lang ? "close" : "ዝጋ", true, ScanMode.QR);
              print("from scanner" + scanning);
              if (scanning != '-1') {
                String identifier = extractUserNameFromFakeUrl(scanning);
                print(identifier);
                if (identifier.length == 8) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScannedMeeting(
                                lang: widget.lang,
                                username: widget.username,
                                scanned_user: identifier,
                                app_current_background:
                                    widget.app_current_background,
                                app_current_text: widget.app_current_text,
                              )));
                } else {
                  print('inside visit');
                  String venue_name_extracted =
                      getVenueName(scanned_string: scanning);
                  // String venue_name = 'test';
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScannedVisit(
                                lang: widget.lang,
                                username: widget.username,
                                venue: identifier,
                                venue_name: venue_name_extracted,
                                app_current_background:
                                    widget.app_current_background,
                                app_current_text: widget.app_current_text,
                              )));
                }
              }
            },
            icon: Icon(
              Icons.speaker_phone,
              size: 40,
            ),
            label: Text(
              widget.lang ? 'Tap to scan' : 'ለማንበብ ይጫኑ',
              style: TextStyle(fontSize: 35),
            )),
      ),
    );
  }
}
