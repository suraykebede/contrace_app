import 'package:flutter/material.dart';
import 'package:trace_et/Data/Constants/Colors/Init/header_colors.dart';
import 'package:trace_et/Pages/Init/Signin/Login.dart';
import 'package:trace_et/Pages/Init/Signin/signup.dart';

class SignInPromptPage extends StatefulWidget {
  @override
  _SignInPromptPageState createState() => _SignInPromptPageState();
}

class _SignInPromptPageState extends State<SignInPromptPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: header_text_background_color,
            centerTitle: true,
            title: Text(
              'TraceEt',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                  color: header_text_color),
            ),
            bottom: TabBar(
                labelColor: header_text_color,
                indicatorColor: header_text_color,
                tabs: [
                  Tab(
                    text: 'Sign in',
                  ),
                  Tab(text: 'Sign up')
                ]),
          ),
          body: TabBarView(children: [Login(), SignUp()]),
        ));
  }
}
