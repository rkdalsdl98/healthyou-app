import 'dart:convert';

import 'package:healthyou_app/datasource/localdatas.dart';

import '../model/calendar/event_model.dart';

class CalendarRepository {
  List<EventModel> _selectedEvents = [];
  List<EventModel> get selectedEvents => _selectedEvents;

  final Map<String, List<EventModel>> _events = {};
  Map<String, List<EventModel>> get events => _events;

  Future<void> initialized() async {
    await LocalDataManager.getStringData("calendar-memo").then((value) {
      if (value != null && value != "null" && value != "") {
        var jsonMap = jsonDecode(value);
        for (var jsonList in jsonMap.values) {
          for (var json in jsonList) {
            EventModel event = EventModel.fromJson(json);
            final date = event.notifyDate ?? DateTime.now();
            _events.update(
              "${date.year}:${date.month}:${date.day}",
              (events) => [...events, event],
              ifAbsent: () => [event],
            );
          }
        }
      }
      final now = DateTime.now();
      _selectedEvents = _events["${now.year}:${now.month}:${now.day}"] ?? [];
    });
  }

  void addEvent(Map<String, dynamic> data) {
    EventModel event = EventModel.fromJson(data);
    final date = event.notifyDate ?? DateTime.now();
    _events.update(
      "${date.year}:${date.month}:${date.day}",
      (events) {
        event.addOrder(events.length);
        return [...events, event];
      },
      ifAbsent: () {
        event.addOrder(0);
        return [event];
      },
    );

    final Map<String, dynamic> convertJsonDatas = {};
    for (var key in _events.keys) {
      convertJsonDatas.addAll({key.toString(): _events[key]});
    }

    LocalDataManager.saveStringData(
        "calendar-memo", jsonEncode(convertJsonDatas));
  }

  void removeEvent(DateTime date, int order) {
    _events.update(
      "${date.year}:${date.month}:${date.day}",
      (prev) {
        prev.removeWhere((e) => e.order == order);
        return prev;
      },
    );

    final Map<String, dynamic> convertJsonDatas = {};
    for (var key in _events.keys) {
      convertJsonDatas.addAll({key.toString(): _events[key]});
    }

    LocalDataManager.saveStringData(
        "calendar-memo", jsonEncode(convertJsonDatas));
  }

  void setSelectedEvents(List<EventModel> events) {
    _selectedEvents = events;
  }
}
