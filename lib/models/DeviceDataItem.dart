import 'package:intl/intl.dart';

class DeviceDataItem {
  int id;
  String deviceId;
  String macAddress;
  String ipAddress;
  double soilPH;
  double soilMoisture;
  double temperature;
  double uvIndex;
  double humidityLevel;
  int lightIntensity;
  DateTime createdAt;

  DeviceDataItem(
      this.id,
      this.deviceId,
      this.macAddress,
      this.ipAddress,
      this.soilPH,
      this.soilMoisture,
      this.temperature,
      this.uvIndex,
      this.humidityLevel,
      this.lightIntensity,
      this.createdAt);

  factory DeviceDataItem.fromJson(dynamic json) {
    int id = json['id'] as int;
    String deviceId = json['device_id'] as String;
    String macAddress = json['mac_address'] as String;
    String ipAddress = json['ip_address'] as String;
    double soilPH = json['soil_ph'] as double;
    double soilMoisture = json['soil_moisture'] as double;
    double temperature = json['temperature'] as double;
    double uvIndex = json['uv_index'] as double;
    double humidityLevel = json['humidity_level'] as double;
    int lightIntensity = json['light_intensity'] as int;
    String createdAtUnixTimestamp = json['created_at'] as String;
    DateTime createdAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(createdAtUnixTimestamp) * 1000);

    return DeviceDataItem(
        id,
        deviceId,
        macAddress,
        ipAddress,
        soilPH,
        soilMoisture,
        temperature,
        uvIndex,
        humidityLevel,
        lightIntensity,
        createdAt);
  }

  String getCreatedAtFormatted() {
    return DateFormat('dd/MM/yyyy hh:mm:ss').format(createdAt);
  }
}
