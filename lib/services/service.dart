import 'dart:async';
import 'dart:convert';

import 'package:diu_smhd_app/models/Alert.dart';
import 'package:diu_smhd_app/models/DeviceDataItem.dart';
import 'package:diu_smhd_app/models/LastDataItem.dart';
import 'package:diu_smhd_app/models/Metrics.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String DEVICE_ID_KEY = "device_id";

const String PH_SOIL_MIN_KEY = "PH_SOIL_MIN_KEY";
const String PH_SOIL_MAX_KEY = "PH_SOIL_MAX_KEY";
const String SOIL_MOISTURE_MIN_KEY = "SOIL_MOISTURE_MIN_KEY";
const String SOIL_MOISTURE_MAX_KEY = "SOIL_MOISTURE_MAX_KEY";
const String UV_INDEX_MIN_KEY = "UV_INDEX_MIN_KEY";
const String UV_INDEX_MAX_KEY = "UV_INDEX_MAX_KEY";
const String TEMPERATURE_MIN_KEY = "TEMPERATURE_MIN_KEY";
const String TEMPERATURE_MAX_KEY = "TEMPERATURE_MAX_KEY";
const String HUMIDITY_MIN_KEY = "HUMIDITY_MIN_KEY";
const String HUMIDITY_MAX_KEY = "HUMIDITY_MAX_KEY";
const String LIGHT_INTENSITY_MIN_KEY = "LIGHT_INTENSITY_MIN_KEY";
const String LIGHT_INTENSITY_MAX_KEY = "LIGHT_INTENSITY_MAX_KEY";

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

Future<void> saveMetrics(Metrics metrics) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(PH_SOIL_MIN_KEY, metrics.phSoilMin);
  await prefs.setString(PH_SOIL_MAX_KEY, metrics.phSoilMax);
  await prefs.setString(SOIL_MOISTURE_MIN_KEY, metrics.soilMoistureMin);
  await prefs.setString(SOIL_MOISTURE_MAX_KEY, metrics.soilMoistureMax);
  await prefs.setString(UV_INDEX_MIN_KEY, metrics.uvIndexMin);
  await prefs.setString(UV_INDEX_MAX_KEY, metrics.uvIndexMax);
  await prefs.setString(TEMPERATURE_MIN_KEY, metrics.temperatureMin);
  await prefs.setString(TEMPERATURE_MAX_KEY, metrics.temperatureMax);
  await prefs.setString(HUMIDITY_MIN_KEY, metrics.humidityMin);
  await prefs.setString(HUMIDITY_MAX_KEY, metrics.humidityMax);
  await prefs.setString(LIGHT_INTENSITY_MIN_KEY, metrics.lightIntensityMin);
  await prefs.setString(LIGHT_INTENSITY_MAX_KEY, metrics.lightIntensityMax);
}

Future<Metrics> getMetrics() async {
  final prefs = await SharedPreferences.getInstance();

  String phSoilMin = prefs.getString(PH_SOIL_MIN_KEY) ?? "";
  String phSoilMax = prefs.getString(PH_SOIL_MAX_KEY) ?? "";
  String soilMoistureMin = prefs.getString(SOIL_MOISTURE_MIN_KEY) ?? "";
  String soilMoistureMax = prefs.getString(SOIL_MOISTURE_MAX_KEY) ?? "";
  String uvIndexMin = prefs.getString(UV_INDEX_MIN_KEY) ?? "";
  String uvIndexMax = prefs.getString(UV_INDEX_MAX_KEY) ?? "";
  String temperatureMin = prefs.getString(TEMPERATURE_MIN_KEY) ?? "";
  String temperatureMax = prefs.getString(TEMPERATURE_MAX_KEY) ?? "";
  String humidityMin = prefs.getString(HUMIDITY_MIN_KEY) ?? "";
  String humidityMax = prefs.getString(HUMIDITY_MAX_KEY) ?? "";
  String lightIntensityMin = prefs.getString(LIGHT_INTENSITY_MIN_KEY) ?? "";
  String lightIntensityMax = prefs.getString(LIGHT_INTENSITY_MAX_KEY) ?? "";

  return Metrics(
    phSoilMin,
    phSoilMax,
    soilMoistureMin,
    soilMoistureMax,
    uvIndexMin,
    uvIndexMax,
    temperatureMin,
    temperatureMax,
    humidityMin,
    humidityMax,
    lightIntensityMin,
    lightIntensityMax,
  );
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
