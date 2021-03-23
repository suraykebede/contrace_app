import 'dart:convert';

import 'package:http/http.dart';
import 'package:trace_et/Connectivity/Objects/login_auth_object.dart';
import 'package:trace_et/Connectivity/Objects/meeting_object.dart';
import 'package:trace_et/Connectivity/Objects/signup_auth_object.dart';
import 'package:trace_et/Connectivity/Objects/visit_object.dart';
import 'package:trace_et/Connectivity/Responses/response_with_msg.dart';
import 'package:trace_et/Connectivity/api_endpoint.dart';
import 'package:trace_et/Connectivity/Objects/meeting_from_dbase.dart';
import 'package:trace_et/Connectivity/Objects/visit_from_dbase.dart';
import 'package:trace_et/Connectivity/Objects/notification_object.dart';
import 'package:trace_et/Connectivity/Objects/change_coords_object.dart';
import 'package:trace_et/Connectivity/Objects/venue_information_object.dart';
import 'package:trace_et/Utilities/get_device_id.dart';

class HttpService {
  Future<List<NotificationFromDBase>> get_notifications(
      {String username}) async {
    Response res =
        await get(API_ENDPOINT + '/notifications/user?username=$username');
    var notifications = List<NotificationFromDBase>();
    if (res.statusCode == 200) {
      var notificationsJson = json.decode(res.body);
      print(notificationsJson.toString());
      for (var notification in notificationsJson) {
        notifications.add(NotificationFromDBase.fromJson(notification));
      }
    }
    return notifications;
  }

  Future<List<NotificationFromDBase>> get_Venue_notifications(
      {String venue}) async {
    Response res =
        await get(API_ENDPOINT + '/notifications/venue?venue=$venue');
    var notifications = List<NotificationFromDBase>();
    if (res.statusCode == 200) {
      var notificationsJson = json.decode(res.body);
      print(notificationsJson.toString());
      for (var notification in notificationsJson) {
        notifications.add(NotificationFromDBase.fromJson(notification));
      }
    }
    return notifications;
  }

  Future<List<VisitFromDBase>> get_visits({String username}) async {
    Response res =
        await get(API_ENDPOINT + '/history/visits?username=$username');
    var visits = List<VisitFromDBase>();
    if (res.statusCode == 200) {
      var visitsJson = json.decode(res.body);
      print(visitsJson.toString());
      for (var visit in visitsJson) {
        print('visit => ${visit.toString()}');
        visits.add(VisitFromDBase.fromJson(visit));
      }
    }
    return visits;
  }

  Future<List<MeetingFromDbase>> get_meetings({String username}) async {
    Response res =
        await get(API_ENDPOINT + '/history/meetings?username=$username');
    var meetings = List<MeetingFromDbase>();
    if (res.statusCode == 200) {
      var meetingsJson = json.decode(res.body);
      print(meetingsJson.toString());
      for (var meeting in meetingsJson) {
        meetings.add(MeetingFromDbase.fromJson(meeting));
      }
    }
    return meetings;
  }

  Future<ResponseWithMsg> verify_device({String device_id}) async {
    Response res =
        await get(API_ENDPOINT + '/verifydevice?deviceid=$device_id');
    if (res.statusCode == 200) {
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      return ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<ResponseWithMsg> logout() async {
    String device_id = await get_device_id();
    Response res = await delete(API_ENDPOINT + '/logout?device_id=$device_id');
    if (res.statusCode == 200) {
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      return ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<ResponseWithMsg> add_device(
      {String username, String device_id}) async {
    Response res = await get(
        API_ENDPOINT + '/add_device?username=$username&device_name=$device_id');
    if (res.statusCode == 200) {
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      return ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<VenueInformationObject> get_venue_information(
      {String username}) async {
    Response res =
        await get(API_ENDPOINT + '/get_venue_info?username=$username');
    if (res.statusCode == 200) {
      var responseJson = json.decode(res.body);
      print(responseJson.toString());
      VenueInformationObject venueInformationObject =
          VenueInformationObject.fromJson(responseJson);
      print(" inside the http class " +
          venueInformationObject.attendees.toString());
      return venueInformationObject;
    } else {
      return null;
    }
  }

  Future<ResponseWithMsg> change_user_coords(
      ChangeCoordsObject changeCoordsObject) async {
    Response res = await post(API_ENDPOINT + '/change_coords',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': changeCoordsObject.username,
          'new_latitude': changeCoordsObject.new_latitude.toString(),
          'new_longitude': changeCoordsObject.new_longitude.toString()
        }));
    if (res.statusCode == 200) {
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      return ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<ResponseWithMsg> current_venue({String username}) async {
    Response res =
        await get(API_ENDPOINT + '/currentvenue?username=' + username);
    if (res.statusCode == 200) {
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      return ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<ResponseWithMsg> image_getter(String username) async {
    Response res = await get(API_ENDPOINT + '/imagegetter?username=$username');
    if (res.statusCode == 200) {
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      return ResponseWithMsg(msg: "ERROR");
    }
  }

  Future<ResponseWithMsg> get_phonenumber(String username) async {
    Response res =
        await get(API_ENDPOINT + '/get_phonenumber?username=$username');
    if (res.statusCode == 200) {
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      return ResponseWithMsg(msg: "ERROR");
    }
  }

  Future<ResponseWithMsg> get_fullname(String username) async {
    Response res =
        await get(API_ENDPOINT + '/getfullname?username=$username&string=true');
    if (res.statusCode == 200) {
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      return ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<ResponseWithMsg> verify_username(String username) async {
    Response res = await get(API_ENDPOINT + '/verifyuser?username=$username');
    if (res.statusCode == 200) {
      print('returning');
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      return ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<ResponseWithMsg> add_visit({VisitObject visit_object}) async {
    Response res = await post(API_ENDPOINT + "/history/visits/add",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'venue': visit_object.venue,
          'username': visit_object.username
        }));
    if (res.statusCode == 200) {
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<ResponseWithMsg> add_meeting({Meeting meeting_object}) async {
    Response res = await post(API_ENDPOINT + "/history/meetings/add",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username_one': meeting_object.username_one,
          'username_two': meeting_object.username_two,
          'meeting_latitude': meeting_object.meeting_latitude.toString(),
          'meeting_longitude': meeting_object.meeting_longitude.toString(),
        }));
    if (res.statusCode == 200) {
      print('we dont know yet');
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<ResponseWithMsg> add_user(SignupAuthObject signup_auth_obj) async {
    Response res = await post(API_ENDPOINT + '/adduser',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'current_venue': signup_auth_obj.current_venue,
          'image': signup_auth_obj.image,
          'first_name': signup_auth_obj.first_name,
          'last_name': signup_auth_obj.last_name,
          "home_latitude": signup_auth_obj.home_latitude.toString(),
          "home_longitude": signup_auth_obj.home_longitude.toString(),
          "email": signup_auth_obj.email,
          "gender": signup_auth_obj.gender,
          "password": signup_auth_obj.password,
          "age": signup_auth_obj.age.toString(),
          "phone_number": signup_auth_obj.phone_number,
          "psh_key": signup_auth_obj.psh_key,
          "username": signup_auth_obj.username
        }));
    if (res.statusCode == 200) {
      print('we dont know yet');
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else {
      ResponseWithMsg(msg: 'ERROR');
    }
  }

  Future<ResponseWithMsg> auth_user(
      {LoginAuthObject my_login_auth_object}) async {
    String username = my_login_auth_object.Username;
    String password = my_login_auth_object.Password;
    print('auth with $username and $password');

    Response res = await get(
      API_ENDPOINT + '/auth/user?username=$username&password=$password',
    );
    if (res.statusCode == 200) {
      print('returning');
      return ResponseWithMsg.fromJson(json.decode(res.body));
    } else
      return ResponseWithMsg(msg: 'ERROR');
  }
}
