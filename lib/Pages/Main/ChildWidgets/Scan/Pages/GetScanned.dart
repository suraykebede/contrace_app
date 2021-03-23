//import 'package:contact_tracer/Constants/Colors.dart';
import '../../../../../Data/Constants/Sizes.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GetScanned extends StatefulWidget {
  Color app_current_background;
  Color app_current_text;
  String username;

  GetScanned(
      {this.app_current_background, this.app_current_text, this.username})
      : super();

  @override
  _GetScannedState createState() => _GetScannedState();
}

class _GetScannedState extends State<GetScanned> {
  @override
  Widget build(BuildContext context) {
    print('username ${widget.username}');
    String authorization = 'http://${widget.username}.Michael_Trent.me';
    // String authorization = 'http://@robert9.Michael_Trent.me';
    return Container(
      child: Center(
        child: QrImage(
            data: authorization,
            size: screenHeightExcludingToolbar(
              context,
              dividedBy: 2,
            )),
      ),
    );
  }
}
