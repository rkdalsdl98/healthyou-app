import 'package:healthyou_app/system/unit_system.dart';

class NotifyModel {
  final int id;
  String? identifier, message, title, widgetTitle;
  int? hour, minute;
  bool? isActive;

  NotifyModel({
    required this.id,
    this.identifier,
    this.hour,
    this.minute,
    this.message,
    this.title,
    this.widgetTitle,
    this.isActive,
  });
  NotifyModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        identifier = json['identifier'],
        hour = json['hour'],
        minute = json['minute'],
        message = json['message'],
        title = json['title'],
        widgetTitle = json['widgetTitle'],
        isActive = json['active'];
  Map<String, dynamic> toJson() => {
        "id": id,
        "identifier": identifier,
        "hour": hour,
        "minute": minute,
        "message": message,
        "title": title,
        "widgetTitle": widgetTitle,
        "active": isActive,
      };

  void setHour(int newHour) => hour = newHour;
  void setMinute(int newMinute) => minute = newMinute;
}
