import 'dart:convert';

import 'package:healthyou_app/datasource/localdatas.dart';
import 'package:healthyou_app/model/meal/meal_history_model.dart';
import 'package:healthyou_app/model/meal/total_nutrition_model.dart';

import '../model/meal/meal_preset_model.dart';

class MealRepository {
  final int _presetsMaxLength = 10;

  Map<int, List<MealPresetModel>> _presets = {};
  Map<int, List<MealPresetModel>> get presets => _presets;

  Map<String, dynamic> _presetsStates = {};
  Map<String, dynamic> get presetsStates => _presetsStates;

  final TotalNutritionModel _totalNutrients = TotalNutritionModel();
  TotalNutritionModel get totalNutrients => _totalNutrients;

  List<MealHistoryModel> _historys = [];
  List<MealHistoryModel> get historys => _historys;

  String updated = "";

  Future<void> initialized(bool resetData) async {
    if (resetData) {
      await reset();
    }
    await LocalDataManager.getStringData("meal-historys").then((list) {
      if (list != null && list != "") {
        final List<dynamic> jsonList = jsonDecode(list);
        for (var e in jsonList) {
          _historys.add(MealHistoryModel.fromJson(e));
        }
      }
    });
    await LocalDataManager.getStringListData("meal-presets").then((list) async {
      if (list != null) {
        await LocalDataManager.getStringData("meal-states").then((states) {
          if (states != null && states.isNotEmpty) {
            final convertStates = jsonDecode(states);
            for (int i = 0; i < list.length; ++i) {
              final List<dynamic> jsonList = jsonDecode(list[i]);
              updatePresetsState(i, convertStates["$i"]!);
              if (jsonList.isNotEmpty) {
                for (var e in jsonList) {
                  addPresetInfo(e);
                }
              }
            }
          } else {
            for (int i = 0; i < list.length; ++i) {
              final List<dynamic> jsonList = jsonDecode(list[i]);
              updatePresetsState(i, "idle");
              if (jsonList.isNotEmpty) {
                for (var e in jsonList) {
                  addPresetInfo(e);
                }
              }
            }
          }
        });
      }
    });
  }

  void addHistory(MealHistoryModel history, bool result) {
    if (history.index != 0 &&
        _historys.every((e) => e.index != history.index
            ? _presetsStates["${e.index}"] == "idle"
            : true)) {
      throw Error.safeToString("PrevIsNotCheck");
    }
    _historys.add(history);
    if (result) {
      updatePresetsState(history.index!, "done");
    } else {
      updatePresetsState(history.index!, "un_done");
    }
    LocalDataManager.saveStringData("meal-historys", jsonEncode(_historys));
    LocalDataManager.saveStringData("meal-states", jsonEncode(_presetsStates));
  }

  void clearHistory() {
    _historys = [];
    LocalDataManager.saveStringData("meal-historys", "");
  }

  void updatePresetsState(int currIndex, String state) {
    _presetsStates.update(
      "$currIndex",
      (_) => state,
      ifAbsent: () => state,
    );
  }

  void addPresetInfo(Map<String, dynamic> info) {
    if (_presets.length >= _presetsMaxLength) {
      throw Error.safeToString("RangeOverException");
    }

    final presetInfo = MealPresetModel.fromJson(info);
    _totalNutrients.addNutrients({
      'calorie': presetInfo.calorie!,
      'carbohydrate': presetInfo.carbohydrate!,
      'fat': presetInfo.fat!,
      'protein': presetInfo.protein!,
    });
    _presets.update(
      presetInfo.index!,
      (prev) {
        presetInfo.addOrder(prev.length);
        return [...prev, presetInfo];
      },
      ifAbsent: () {
        presetInfo.addOrder(_presets.length);
        return [presetInfo];
      },
    );
  }

  void removePresetInfo(int key, int order) {
    if (_presets.containsKey(key)) {
      _presets[key]!.removeWhere((e) {
        final res = e.order == order;
        if (res) {
          _totalNutrients.subtractNutrients({
            'calorie': e.calorie!,
            'carbohydrate': e.carbohydrate!,
            'fat': e.fat!,
            'protein': e.protein!,
          });
        }
        return res;
      });
    }
  }

  void removePreset(int key) {
    _presets.remove(key);

    Map<int, List<MealPresetModel>> temp = {};
    _presets.forEach((prevKey, value) {
      prevKey = prevKey > key ? --prevKey : prevKey;
      temp.addAll({prevKey: value});
    });

    _presets = temp;
    savePresets();
  }

  void editPresetInfo(MealPresetModel newInfo) {
    if (_presets.containsKey(newInfo.index)) {
      var preset = _presets[newInfo.index]!;
      final order = preset.indexWhere((e) => e.order == newInfo.order);
      final diffs = newInfo.getDiffs(preset[order]);
      _totalNutrients.addNutrients(diffs);
      preset[order] = newInfo;
    }
  }

  void changePresetsLen(int len) {
    Map<int, List<MealPresetModel>> temp = {};
    _presets.forEach((prevKey, value) {
      if (prevKey <= len) {
        temp.addAll({prevKey: value});
      } else {
        for (int i = 0; i < value.length; ++i) {
          _totalNutrients.subtractNutrients({
            'calorie': value[i].calorie!,
            'carbohydrate': value[i].carbohydrate!,
            'fat': value[i].fat!,
            'protein': value[i].protein!,
          });
        }
        _presetsStates.removeWhere((key, _) => key == "$prevKey");
        _historys.removeWhere((e) => e.index == prevKey);
      }
    });
    _presets = temp;
  }

  void clearPresets() {
    _presets = {};
    _presetsStates = {};
    _historys = [];
    LocalDataManager.saveStringListData("meal-presets", null);
    LocalDataManager.saveStringData("meal-states", null);
    LocalDataManager.saveStringData("meal-historys", null);
  }

  Future<void> reset() async {
    _presetsStates = {};
    _historys = [];
    await LocalDataManager.saveStringData("meal-states", null);
    await LocalDataManager.saveStringData("meal-historys", null);
  }

  void savePresets() {
    List<String> datas = [];
    _presets.forEach((index, value) {
      if (!_presetsStates.containsKey("$index")) {
        _presetsStates["$index"] = "idle";
      }
      datas.add(jsonEncode(value));
    });

    LocalDataManager.saveStringListData("meal-presets", datas);
    LocalDataManager.saveStringData("meal-states", jsonEncode(_presetsStates));
    LocalDataManager.saveStringData("meal-historys", jsonEncode(_historys));
  }
}
