class CalendarNotifyModel {
  final int id;
  String? message;
  int? year, month, day;

  CalendarNotifyModel({
    required this.id,
    this.message,
  });

  CalendarNotifyModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        year = json['year'],
        month = json['month'],
        day = json['day'],
        message = json['message'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "month": month,
        "day": day,
        "message": message,
      };
}
