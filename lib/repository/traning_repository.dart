import 'dart:convert';

import 'package:healthyou_app/datasource/localdatas.dart';
import 'package:healthyou_app/model/traning/traning_preset_model.dart';
import 'package:healthyou_app/model/traning/traning_schedule_model.dart';

import '../types/date_types.dart';

class TraningRepository {
  List<TraningPreset> _presets = [];
  List<TraningPreset> get presets => _presets;

  final Map<String, TraningScheduleModel> _schedules = {};
  Map<String, TraningScheduleModel> get schedules => _schedules;

  int _achievementDays = 0;
  int? get achievementDays => _achievementDays;

  Future<void> initialized(bool resetData) async {
    if (resetData) {
      await reset();
    }
    await LocalDataManager.getIntData("achievement-days")
        .then((value) => _achievementDays = value ?? 0);

    await LocalDataManager.getStringData("traning-presets").then((list) {
      if (list != null && list.isNotEmpty) {
        var json = jsonDecode(list);
        _presets =
            json.map<TraningPreset>((e) => TraningPreset.fromJson(e)).toList();
      }
    });

    await LocalDataManager.getStringData("traning-schedules").then((value) {
      if (value != "null" &&
          value != null &&
          value.isNotEmpty &&
          value != "" &&
          value != "{}") {
        var json = jsonDecode(value);

        for (var daily in DateTypes.DAYS.values) {
          if (json[daily] == null || json[daily].isEmpty) {
            throw Error.safeToString("ScheduleIsNotValid");
          }

          final schedule = TraningScheduleModel.fromJson(json[daily]);
          updateSchedule(
            daily,
            schedule,
            currPreset: schedule.schedule,
            isInit: true,
          );
        }
      } else {
        for (var daily in DateTypes.DAYS.values) {
          updateSchedule(daily, TraningScheduleModel(daily: daily));
        }
      }
    });
  }

  bool isValidPresetByIndex(int index) {
    var res = false;
    for (int i = 0; i < _presets.length; ++i) {
      if (_presets[i].index == index) {
        res = true;
        break;
      }
    }
    return res;
  }

  bool isValidPresetByName(String name) {
    var res = false;
    for (int i = 0; i < _presets.length; ++i) {
      if (_presets[i].name == name) {
        res = true;
        break;
      }
    }
    return res;
  }

  void increaseAchievementDays() {
    ++_achievementDays;
    LocalDataManager.saveIntData("achievement-days", _achievementDays);
  }

  void decreaseAchievementDays() {
    --_achievementDays;
    LocalDataManager.saveIntData("achievement-days", _achievementDays);
  }

  void addPreset(
    String name,
    List<dynamic> datas, {
    String? daily,
  }) {
    var findItem = false;
    List<TraningPreset> temp = [];
    try {
      for (var e in _presets) {
        if (e.name == name) {
          findItem = true;
          e = TraningPreset(
            index: e.index,
            name: e.name,
            presetItems: datas,
            daily: daily,
          );
        }
        temp.add(e);
      }

      if (findItem) {
        _presets = temp;
      } else {
        _presets.add(TraningPreset(
          index: _presets.length,
          name: name,
          presetItems: datas,
        ));
      }

      LocalDataManager.saveStringData("traning-presets", jsonEncode(_presets));
    } catch (e) {
      rethrow;
    }
  }

  void removePreset(int index) {
    final List<TraningPreset> temp = [];

    for (var e in _presets) {
      if (e.index != index) {
        temp.add(e);
      }
    }
    _presets = temp;
    LocalDataManager.saveStringData("traning-presets", jsonEncode(_presets));
  }

  TraningScheduleModel? getSchedule(String daily) {
    return _schedules[daily];
  }

  void updateSchedule(
    String daily,
    TraningScheduleModel schedule, {
    TraningPreset? currPreset,
    bool isInit = false,
  }) {
    if (!isInit && currPreset != null) {
      if (currPreset.daily != null) {
        throw Error.safeToString("PresetIsAlready");
      }
      addPreset(currPreset.name!, currPreset.presetItems!, daily: daily);
    }

    _schedules.update(
      daily,
      (_) => schedule,
      ifAbsent: () => schedule,
    );

    LocalDataManager.saveStringData(
        "traning-schedules", jsonEncode(_schedules));
  }

  void resetSchedule(String daily) {
    _schedules.update(
      daily,
      (prev) {
        if (prev.schedule != null) {
          addPreset(
            prev.schedule!.name!,
            prev.schedule!.presetItems!,
            daily: null,
          );
        }

        if (prev.state != "idle") {
          decreaseAchievementDays();
        }
        prev.completes = 0;
        prev.schedule = null;
        prev.state = "idle";
        return prev;
      },
    );

    LocalDataManager.saveStringData(
        "traning-schedules", jsonEncode(_schedules));
  }

  void removeSchedule(String daily) {
    _schedules.update(
      daily,
      (prev) {
        prev.schedule = null;
        prev.state = "idle";
        prev.completes = 0;
        return prev;
      },
    );

    LocalDataManager.saveStringData(
        "traning-schedules", jsonEncode(_schedules));
  }

  Future<void> reset() async {
    _schedules.updateAll((_, schedule) {
      schedule.state = "idle";
      schedule.completes = 0;
      return schedule;
    });

    await LocalDataManager.saveStringData(
        "traning-schedules", jsonEncode(_schedules));
  }
}
