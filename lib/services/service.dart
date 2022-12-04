import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const String DEVICE_ID_KEY = "device_id";

Future<void> saveDeviceId(deviceId) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(DEVICE_ID_KEY, deviceId);
}

Future<void> removeDeviceId() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove(DEVICE_ID_KEY);
}

Future<String?> getDeviceId() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString(DEVICE_ID_KEY);
}
