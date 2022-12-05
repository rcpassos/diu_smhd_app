import 'dart:async';
import 'dart:convert';
import 'package:diu_smhd_app/models/Alert.dart';
import 'package:flutter/services.dart';
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

Future<List<Alert>> getAlerts() async {
  var json = await rootBundle.loadString('lib/services/mock_data/alerts.json');

  var alertsJsonObj = jsonDecode(json) as List;
  List<Alert> alerts = alertsJsonObj.map((alertJson) => Alert.fromJson(alertJson)).toList();

  return alerts;
}
