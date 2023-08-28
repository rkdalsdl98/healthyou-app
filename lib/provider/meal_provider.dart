import 'package:flutter/material.dart';
import 'package:healthyou_app/repository/meal_repository.dart';

import '../model/meal/meal_history_model.dart';
import '../model/meal/meal_preset_model.dart';
import '../model/meal/total_nutrition_model.dart';

enum MealState {
  ready,
  empty,
}

class MealProvider extends ChangeNotifier {
  MealRepository? repository;
  Map<int, List<MealPresetModel>> get presets => repository!.presets;
  TotalNutritionModel get totalNutrients => repository!.totalNutrients;
  List<MealHistoryModel> get historys => repository!.historys;
  Map<String, dynamic> get presetsStates => repository!.presetsStates;

  MealState state = MealState.empty;
  bool isReady = false;

  MealProvider(bool? resetData, {this.repository}) {
    initialized(resetData);
  }

  initialized(bool? resetData) {
    repository ??= MealRepository();
    repository?.initialized(resetData ?? false).then((_) {
      if (presets.isNotEmpty) {
        state = MealState.ready;
      }
      isReady = true;
      notifyListeners();
    });
  }

  void removePreset(int key) {
    repository?.removePreset(key);
    notifyListeners();
  }

  void removePresetInfo(int key, int order) {
    repository?.removePresetInfo(key, order);
    notifyListeners();
  }

  void changePresetsLen(int len) {
    repository?.changePresetsLen(len);
    notifyListeners();
  }

  void clearPresets() {
    repository?.clearPresets();
    state = MealState.empty;
    notifyListeners();
  }

  void addPresetInfo(Map<String, dynamic> info) {
    repository?.addPresetInfo(info);
    notifyListeners();
  }

  void editPresetInfo(Map<String, dynamic> info) {
    repository?.editPresetInfo(MealPresetModel.fromJson(info));
    notifyListeners();
  }

  void savePresets() {
    repository?.savePresets();
    if (presets.isEmpty) {
      state = MealState.empty;
    } else {
      state = MealState.ready;
    }
    notifyListeners();
  }

  void addHistory(Map<String, dynamic> data, bool result) {
    try {
      repository?.addHistory(MealHistoryModel.fromJson(data), result);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void clearHistory() {
    repository?.clearHistory();
    notifyListeners();
  }

  void updatePresetState(int currIndex, String state) {
    repository?.updatePresetsState(currIndex, state);
    notifyListeners();
  }

  void reset() {
    repository?.reset();
    notifyListeners();
  }
}
