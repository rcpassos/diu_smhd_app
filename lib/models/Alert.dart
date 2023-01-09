
import 'package:intl/intl.dart';

class Alert {
  int id;
  String title;
  String message;
  DateTime createdAt;
  String deviceId;

  Alert(this.id, this.title, this.message, this.createdAt, this.deviceId);

  factory Alert.fromJson(dynamic json) {
    int id = json['id'] as int;
    String title = json['title'] as String;
    String message = json['message'] as String;
    String createdAtUnixTimestamp = json['created_at'] as String;
    DateTime createdAt = DateTime.fromMicrosecondsSinceEpoch(int.parse(createdAtUnixTimestamp) * 1000);
    String deviceId = json['device_id'] as String;

    return Alert(id, title, message, createdAt, deviceId);
  }

  String getCreatedAtFormatted() {
    return DateFormat('dd/MM/yyyy hh:mm:ss').format(createdAt);
  }
}