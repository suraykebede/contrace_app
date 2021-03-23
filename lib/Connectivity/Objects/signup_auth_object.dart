import 'dart:io' as Io;
import 'dart:convert';

import 'package:trace_et/Connectivity/MyConnectifier/http_service.dart';

class SignupAuthObject {
  String image;
  String first_name;
  String last_name;
  double home_latitude;
  double home_longitude;
  String phone_number;
  String gender;
  int age;
  String email;
  String username;
  String password;
  String psh_key;
  String current_venue;

  SignupAuthObject(
      {this.image,
      this.first_name,
      this.last_name,
      this.home_latitude,
      this.home_longitude,
      this.current_venue,
      this.email,
      this.gender,
      this.password,
      this.phone_number,
      this.psh_key,
      this.age,
      this.username});
}
