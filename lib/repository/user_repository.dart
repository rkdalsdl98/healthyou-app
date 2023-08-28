import 'dart:convert';

import 'package:healthyou_app/model/user/user_info_model.dart';

import '../datasource/localdatas.dart';

class UserRepository {
  UserInfoModel? _info;
  UserInfoModel? get info => _info;

  int _dayOfCount = -1;
  int _prevWeekDay = -1;

  initialized() async {
    await LocalDataManager.getStringData("updated").then((value) {
      if (value != null && value != "" && value != "null") {
        final splitData = value.split(":");
        _dayOfCount = int.parse(splitData[0]);
        _prevWeekDay = int.parse(splitData[1]);
      }
    });
    await LocalDataManager.getStringData("user-info").then((data) {
      if (data != null && data != "" && data != "null") {
        final json = jsonDecode(data);
        _info = UserInfoModel.fromJson(json);
      }
    });
  }

  String checkUpdated() {
    String updated = "idle";

    final now = DateTime.now();
    if (_prevWeekDay != now.weekday) {
      if (_dayOfCount < 0 || _prevWeekDay < 0) {
        _dayOfCount = 0;
      } else {
        if (_dayOfCount >= 6 || now.weekday == 1) {
          updated = "weekly";
          _dayOfCount = 0;
        } else {
          updated = "daily";
          ++_dayOfCount;
        }
      }
      _prevWeekDay = now.weekday;
      LocalDataManager.saveStringData("updated", "$_dayOfCount:$_prevWeekDay");
    }

    return updated;
  }

  void updateInfo(Map<String, dynamic> data) {
    _info = UserInfoModel.fromJson(data);
    LocalDataManager.saveStringData("user-info", jsonEncode(_info));
  }

  void clearInfo() {
    _info = null;
    LocalDataManager.saveStringData("user-info", jsonEncode(_info));
  }
}
