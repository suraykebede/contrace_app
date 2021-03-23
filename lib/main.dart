import 'package:flutter/material.dart';
import 'package:trace_et/Pages/Init/initial_loading_page.dart';
import 'package:trace_et/Pages/Init/sign_in_prompt_page.dart';
import 'package:trace_et/Pages/Main/Operator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TraceEt',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InitialLoadingPage());
  }
}
