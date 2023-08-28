import 'package:flutter/material.dart';
import 'package:healthyou_app/model/timer/timer_preset_model.dart';
import 'package:healthyou_app/repository/timer_repository.dart';

class TimerProvider extends ChangeNotifier {
  TimerRepository? repository;
  List<TimerPresetModel> get presets => repository!.presets;
  TimerState? get state => repository?.state;

  bool isReady = false;

  TimerProvider({
    this.repository,
  }) {
    repository ??= TimerRepository();
    repository?.initialized().then((_) {
      isReady = true;
      notifyListeners();
    });
  }

  void addPreset(
    String key,
    int minute,
    int seconds,
  ) {
    try {
      repository?.addPreset(key, minute, seconds);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void removePreset(String key) {
    try {
      repository?.removePreset(key);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void changeTimerState(TimerState state) {
    repository?.setState(state);
    notifyListeners();
  }
}
