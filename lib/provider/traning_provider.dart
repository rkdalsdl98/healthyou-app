import 'package:flutter/foundation.dart';
import 'package:healthyou_app/model/traning/traning_preset_model.dart';
import 'package:healthyou_app/model/traning/traning_schedule_model.dart';
import 'package:healthyou_app/repository/traning_repository.dart';

class TraningProvider extends ChangeNotifier {
  TraningRepository? repository;
  List<TraningPreset> get presets => repository!.presets;
  Map<String, TraningScheduleModel> get schedules => repository!.schedules;

  int? get achievementDays => repository?.achievementDays;
  bool isReady = false;

  TraningProvider(bool? resetData, {this.repository}) {
    repository ??= TraningRepository();
    initialized(resetData);
  }

  initialized(bool? resetData) {
    repository?.initialized(resetData ?? false).then((_) {
      isReady = true;
      notifyListeners();
    });
  }

  bool isValidPresetByIndex(int index) {
    return repository!.isValidPresetByIndex(index);
  }

  bool isValidPresetByName(String name) {
    return repository!.isValidPresetByName(name);
  }

  void increaseAchievementDays() {
    repository?.increaseAchievementDays();
    notifyListeners();
  }

  void decreaseAchievementDays() {
    repository?.decreaseAchievementDays();
    notifyListeners();
  }

  void addPreset(String name, List<dynamic> datas, {String? daily}) {
    try {
      repository?.addPreset(name, datas, daily: daily);
      if (daily != null) {
        final currSchedule = schedules[daily]!;
        currSchedule.schedule!.changeItems(datas);
        updateSchedule(daily, currSchedule.toJson());
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void removePreset(int index) {
    repository?.removePreset(index);
    notifyListeners();
  }

  void updateSchedule(
    String daily,
    Map<String, dynamic> data, {
    TraningPreset? currPreset,
  }) {
    try {
      repository?.updateSchedule(
        daily,
        TraningScheduleModel.fromJson(data),
        currPreset: currPreset,
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void resetSchedule(String daily) {
    repository?.resetSchedule(daily);
    notifyListeners();
  }

  void removeSchedule(String daily) {
    repository?.removeSchedule(daily);
    notifyListeners();
  }

  TraningScheduleModel? getSchedule(String daily) {
    return repository?.getSchedule(daily);
  }

  reset() async {
    repository?.reset();
    notifyListeners();
  }
}
