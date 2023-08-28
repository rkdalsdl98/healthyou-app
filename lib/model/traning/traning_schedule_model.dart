import 'package:healthyou_app/model/traning/traning_preset_model.dart';

class TraningScheduleModel {
  String? daily, state;
  TraningPreset? schedule;
  int? completes;

  TraningScheduleModel({
    this.daily,
    this.state,
    this.schedule,
    this.completes,
  }) {
    state ??= "idle";
    completes ??= 0;
  }

  TraningScheduleModel.fromJson(Map<String, dynamic> json)
      : daily = json['daily'],
        schedule = json['schedule'] == null
            ? null
            : TraningPreset.fromJson(json['schedule']),
        state = json['state'] ?? "idle",
        completes = json['completes'];

  Map<String, dynamic> toJson() => {
        "daily": daily,
        "schedule": schedule?.toJson(),
        "state": state,
        "completes": completes,
      };

  setCompletes(int newCount) => completes = newCount;
  setState(String newState) => state = newState;
}
