class TimerPresetModel {
  int? minute, seconds;
  String? name;

  TimerPresetModel({
    this.minute,
    this.seconds,
    this.name,
  });

  TimerPresetModel.fromJson(Map<String, dynamic> json)
      : minute = json['minute'],
        seconds = json['seconds'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        "minute": minute,
        "seconds": seconds,
        "name": name,
      };
}
