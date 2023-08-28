import 'package:flutter/foundation.dart';
import 'package:healthyou_app/repository/calendar_repository.dart';

import '../model/calendar/event_model.dart';

class CalendarProvider extends ChangeNotifier {
  CalendarRepository? repository;

  List<EventModel> get selectedEvents => repository!.selectedEvents;
  Map<String, List<EventModel>> get events => repository!.events;

  bool isReady = false;

  CalendarProvider({this.repository}) {
    repository ??= CalendarRepository();
    repository?.initialized().then((_) {
      isReady = true;
      notifyListeners();
    });
  }

  void addEvent(Map<String, dynamic> data) {
    repository?.addEvent(data);
    notifyListeners();
  }

  void removeEvent(DateTime date, int order) {
    repository?.removeEvent(date, order);
    notifyListeners();
  }

  void setSelectedEvents(List<EventModel> events) {
    repository?.setSelectedEvents(events);
    notifyListeners();
  }
}
