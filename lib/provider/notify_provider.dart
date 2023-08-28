import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthyou_app/model/notify/calendar_notify_model.dart';
import 'package:healthyou_app/repository/notify_repository.dart';

import '../model/notify/notify_model.dart';

class NotifyProvider extends ChangeNotifier {
  NotifyRepository? repository;
  List<NotifyModel> get notifies => repository!.notifies;
  List<CalendarNotifyModel> get calendarNotifies =>
      repository!.calendarNotifies;

  bool isReady = false;

  NotifyProvider({this.repository}) {
    repository ??= NotifyRepository();
    repository?.initialzed().then((_) {
      isReady = true;
      notifyListeners();
    });
  }

  void activeNotify(int id, bool isActive) {
    repository?.activeNotify(id, isActive);
  }

  void editNotify(String identifier, Map<String, int> data) {
    repository?.editNotify(identifier, data);
    notifyListeners();
  }

  void cancelMessage(int id) {
    activeNotify(id, false);
    repository?.cancelNotification(id);
    notifyListeners();
  }

  void addNotify(Map<String, dynamic> data) {
    repository?.addNotify(data);
    notifyListeners();
  }

  void registerMessage(
    int id, {
    String? message,
    String? title,
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minutes,
    bool? repeat,
  }) {
    try {
      repository?.registerMessage(
        hour: hour ?? 0,
        minutes: minutes ?? 0,
        id: id,
        title: title ?? "",
        message: message ?? "",
        year: year,
        month: month,
        day: day,
        repeat: repeat,
      );
    } catch (e) {
      rethrow;
    }
    activeNotify(id, true);
    addNotify({
      "id": id,
      "message": message,
      "year": year,
      "month": month,
      "day": day,
    });
    notifyListeners();
  }

  void registerRepeatMessage(
    RepeatInterval repeatInterval, {
    int? id,
    String? message,
    String? title,
  }) {
    try {
      repository?.registerRepeatMessage(
        id: id ?? 0,
        title: title ?? "",
        message: message ?? "",
        repeatInterval: repeatInterval,
      );
    } catch (e) {
      rethrow;
    }
  }

  void removeNotify(int id) {
    repository?.removeNotify(id);
    notifyListeners();
  }

  CalendarNotifyModel? getCalendarNotifyById(int id) {
    int findIndex = calendarNotifies.lastIndexWhere((e) => e.id == id);
    return findIndex == -1 ? null : calendarNotifies[findIndex];
  }
}
