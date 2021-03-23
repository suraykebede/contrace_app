import 'package:flutter/material.dart';

ShowMessage({String msg, BuildContext context}) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}
