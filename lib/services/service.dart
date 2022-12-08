import 'dart:async';
import 'dart:convert';

import 'package:diu_smhd_app/models/Alert.dart';
import 'package:diu_smhd_app/models/DeviceDataItem.dart';
import 'package:diu_smhd_app/models/LastDataItem.dart';
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
  List<Alert> alerts =
      alertsJsonObj.map((alertJson) => Alert.fromJson(alertJson)).toList();

  return alerts;
}

Future<List<DeviceDataItem>> getDeviceData() async {
  var json =
      await rootBundle.loadString('lib/services/mock_data/device_data.json');

  var deviceDataJsonObj = jsonDecode(json) as List;
  List<DeviceDataItem> deviceData = deviceDataJsonObj
      .map((itemJson) => DeviceDataItem.fromJson(itemJson))
      .toList();

  return deviceData;
}

Future<List<LastDataItem>> getLastDeviceData() async {
  var deviceData = await getDeviceData();

  DeviceDataItem lastData = deviceData.last;

  List<LastDataItem> list = [];

  list.add(LastDataItem("PH solo", '${lastData.soilPH.toStringAsFixed(0)} PH'));
  list.add(LastDataItem(
      "Humidade solo", '${lastData.soilMoisture.toStringAsFixed(0)}%'));
  list.add(
      LastDataItem("Índice UV", '${lastData.uvIndex.toStringAsFixed(0)} UV'));
  list.add(LastDataItem(
      "Temperatura", '${lastData.temperature.toStringAsFixed(1)}ºC'));
  list.add(LastDataItem(
      "Humidade", '${lastData.humidityLevel.toStringAsFixed(0)}%'));
  list.add(LastDataItem(
      "Luminosidade", '${lastData.lightIntensity.toStringAsFixed(0)} lx'));
  list.add(LastDataItem(
      "", 'Última atualização: ${lastData.getCreatedAtFormatted()}'));

  return list;
}
