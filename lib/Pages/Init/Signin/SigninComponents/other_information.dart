import 'package:flutter/material.dart';
import 'package:trace_et/Data/Constants/Colors/Init/header_colors.dart';
import 'package:trace_et/Data/Constants/Sizes.dart';
import 'dart:io';

import 'package:trace_et/Pages/Init/Signin/SigninComponents/user_identity_information.dart';
import 'package:trace_et/Utilities/show_messages.dart';

class OtherInformation extends StatefulWidget {
  File clipped_image;
  OtherInformation({this.clipped_image}) : super();

  @override
  _OtherInformationState createState() => _OtherInformationState();
}

class _OtherInformationState extends State<OtherInformation> {
  String first_name;
  String last_name;
  String phone_number = '+251';
  String email = '';
  String gender = "Female";
  int age;
  bool errors = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: header_text_color,
        onPressed: () async {
          if (email == null ||
              phone_number == null ||
              first_name == null ||
              last_name == null ||
              age == null) {
            setState(() {
              errors = true;
            });
          } else {
            print(
                first_name + last_name + email + age.toString() + phone_number);
            final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserIdentityInformation(
                        clipped_image: widget.clipped_image,
                        email: email,
                        first_name: first_name,
                        last_name: last_name,
                        phone_number: phone_number,
                        age: age,
                        gender: gender)));
            print(result.toString());
          }
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
      appBar: AppBar(
        backgroundColor: header_text_color,
        title: Text(errors ? 'Fill empty fields' : 'Create your account'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(
            0, screenHeightExcludingToolbar(context, dividedBy: 80), 0, 0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.file(widget.clipped_image),
                ),
                radius: screenWidth(context, dividedBy: 8),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: screenHeight(context, dividedBy: 8),
              width: screenWidth(context, dividedBy: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: screenWidth(context, dividedBy: 2.5),
                      child: Material(
                        child: Container(
                          width: screenWidth(context, dividedBy: 2.5),
                          child: TextField(
                            onChanged: (value) {
                              this.setState(() {
                                first_name = value;
                              });
                            },
                            decoration: InputDecoration(
                                focusColor: header_text_color,
                                prefixIcon: Icon(Icons.person),
                                hintText: 'First Name'),
                          ),
                        ),
                      )),
                  SizedBox(
                    width: screenWidth(context, dividedBy: 16),
                  ),
                  Container(
                      width: screenWidth(context, dividedBy: 2.5),
                      child: Material(
                        child: Container(
                          width: screenWidth(context, dividedBy: 2.5),
                          child: TextField(
                            onChanged: (value) {
                              this.setState(() {
                                last_name = value;
                              });
                            },
                            decoration: InputDecoration(
                                focusColor: header_text_color,
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Last Name'),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth(context, dividedBy: 1.5),
                  alignment: Alignment.center,
                  child: Material(
                    child: Container(
                      child: TextField(
                        onChanged: (value) {
                          this.setState(() {
                            phone_number = "+251";
                            phone_number = phone_number + value;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixText: '+251',
                            focusColor: header_text_color,
                            prefixIcon: Icon(Icons.phone),
                            hintText: 'Phone'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: screenWidth(context, dividedBy: 1.5),
              alignment: Alignment.center,
              child: Material(
                child: Container(
                  width: screenWidth(context, dividedBy: 1.5),
                  child: TextField(
                    onChanged: (value) {
                      this.setState(() {
                        email = value;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusColor: header_text_color,
                        prefixIcon: Icon(Icons.email),
                        hintText: 'e-mail'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeightExcludingToolbar(context, dividedBy: 60),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth(context, dividedBy: 3.5),
                  alignment: Alignment.center,
                  child: Material(
                    child: Container(
                      width: screenWidth(context, dividedBy: 1.5),
                      child: TextField(
                        onChanged: (value) {
                          this.setState(() {
                            age = int.parse(value);
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusColor: header_text_color,
                            prefixIcon: Icon(Icons.date_range),
                            hintText: 'age'),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth(context, dividedBy: 20)),
                DropdownButton<String>(
                  value: gender,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      gender = newValue;
                    });
                  },
                  items: <String>['Female', 'Male']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
