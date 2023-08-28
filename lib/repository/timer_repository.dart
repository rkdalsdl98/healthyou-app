import 'dart:convert';

import 'package:healthyou_app/datasource/localdatas.dart';
import 'package:healthyou_app/model/timer/timer_preset_model.dart';

enum TimerState {
  start,
  cancel,
  pause,
  idle,
}

class TimerRepository {
  TimerState _state = TimerState.idle;
  List<TimerPresetModel> _presets = [];

  TimerState? get state => _state;
  List<TimerPresetModel> get presets => _presets;

  Future<void> initialized() async {
    await LocalDataManager.getStringData("timer-presets").then((list) {
      if (list != null && list.isNotEmpty) {
        final jsonList = jsonDecode(list);
        for (var json in jsonList) {
          _presets.add(TimerPresetModel.fromJson(json));
        }
      }
    });
  }

  void setState(TimerState newState) => _state = newState;
  void addPreset(
    String key,
    int minute,
    int seconds,
  ) {
    if (_presets.length > 3) {
      throw Error.safeToString("RangeOver");
    }

    List<TimerPresetModel> temp = [];
    var findItem = false;

    for (var e in _presets) {
      if (e.name == key) {
        findItem = true;
        e = TimerPresetModel(
          minute: minute,
          seconds: seconds,
          name: key,
        );
      }
      temp.add(e);
    }

    if (findItem) {
      _presets = temp;
    } else {
      _presets.add(TimerPresetModel(
        name: key,
        minute: minute,
        seconds: seconds,
      ));
    }

    LocalDataManager.saveStringData("timer-presets", jsonEncode(_presets));
  }

  void removePreset(String key) {
    _presets.removeWhere((e) => e.name == key);
    print(_presets);
    LocalDataManager.saveStringData("timer-presets", jsonEncode(_presets));
  }
}
