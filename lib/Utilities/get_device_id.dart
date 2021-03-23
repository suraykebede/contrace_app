import 'package:device_info/device_info.dart';

Future<String> get_device_id() async {
  var deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidDeviceInfo;
  androidDeviceInfo = await deviceInfo.androidInfo;
  String device_identifier = androidDeviceInfo.androidId;
  return device_identifier;
}
