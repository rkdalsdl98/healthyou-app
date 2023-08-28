import 'package:healthyou_app/model/notify/notify_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../system/unit_system.dart';

class LocalDataManager {
  static Future<void> saveStringData(String? key, String? value) async {
    if (key == null) throw 'NullKey';
    final storage = await SharedPreferences.getInstance();
    await storage.setString(key, value ?? '');
  }

  static Future<void> saveStringListData(
      String? key, List<String>? value) async {
    if (key == null) throw 'NullKey';
    final storage = await SharedPreferences.getInstance();
    await storage.setStringList(key, value ?? []);
  }

  static Future<void> saveIntData(String? key, int? value) async {
    if (key == null) throw 'NullKey';
    final storage = await SharedPreferences.getInstance();
    await storage.setInt(key, value ?? 0);
  }

  static Future<List<String>?> getStringListData(String? key) async {
    if (key == null) throw 'NullKey';
    final storage = await SharedPreferences.getInstance();
    return storage.getStringList(key);
  }

  static Future<String?> getStringData(String? key) async {
    if (key == null) throw 'NullKey';
    final storage = await SharedPreferences.getInstance();
    return storage.getString(key);
  }

  static Future<int?> getIntData(String? key) async {
    if (key == null) throw 'NullKey';
    final storage = await SharedPreferences.getInstance();
    return storage.getInt(key);
  }

  static Future<void> removeData(String? key) async {
    if (key == null) throw 'NullKey';
    final storage = await SharedPreferences.getInstance();
    await storage.remove(key);
  }
}

List<NotifyModel> localNotifies = [
  NotifyModel(
    id: 0,
    identifier: "meal",
    hour: 9,
    minute: 0,
    message: "아침식사는 잠을 자며 사용된 에너지를 보충 해줍니다\n근손실이 나기전에 어서 식사를 하로 가시죠!",
    title: '아침식사는 "신" 이다',
    widgetTitle: "아침식사 시간 알림 받기",
    isActive: false,
  ),
  NotifyModel(
    id: 1,
    identifier: "traning",
    hour: 9,
    minute: 0,
    message: "하루를 시작 혹은 마무리를 위한 운동시간 입니다\n열심히 하고 맛잇는걸 먹으러 가시죠!",
    title: '언제나 시작과 끝은 "운동"',
    widgetTitle: "운동시작 시간 알림 받기",
    isActive: false,
  ),
];
