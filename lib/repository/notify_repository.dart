import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:healthyou_app/datasource/localdatas.dart';
import 'package:healthyou_app/model/notify/calendar_notify_model.dart';
import 'package:healthyou_app/model/notify/notify_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../system/unit_system.dart';

class NotifyRepository {
  List<NotifyModel> _notifies = [];
  List<NotifyModel> get notifies => _notifies;

  final List<CalendarNotifyModel> _calendarNotifies = [];
  List<CalendarNotifyModel> get calendarNotifies => _calendarNotifies;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialzed() async {
    await _configureLocalTimeZone();
    await _initializeNotification();
    await LocalDataManager.getStringData("notifys").then((jsonStr) async {
      if (jsonStr != null && jsonStr != "") {
        final list = jsonDecode(jsonStr);
        for (var item in list) {
          _notifies.add(NotifyModel.fromJson(item));
        }
      } else {
        _notifies.addAll(localNotifies);
        await LocalDataManager.saveStringData("notifys", jsonEncode(_notifies));
      }
    });
    await LocalDataManager.getStringData("calendar-notifys").then((value) {
      if (value != null && value != "") {
        final list = jsonDecode(value);
        for (var item in list) {
          _calendarNotifies.add(CalendarNotifyModel.fromJson(item));
        }
      }
    });
  }

  void addNotify(Map<String, dynamic> data) {
    if (!isLocalNotify(data['id'])) {
      _calendarNotifies.add(CalendarNotifyModel.fromJson(data));
      LocalDataManager.saveStringData(
          "calendar-notifys", jsonEncode(_calendarNotifies));
    }
  }

  void removeNotify(int id) {
    if (!isLocalNotify(id)) {
      _calendarNotifies.removeWhere((e) => e.id == id);
      cancelNotification(id);
      LocalDataManager.saveStringData(
          "calendar-notifys", jsonEncode(_notifies));
    }
  }

  void activeNotify(int id, bool isActive) {
    if (isLocalNotify(id)) {
      _notifies = _notifies.map<NotifyModel>((e) {
        if (e.id == id) {
          e.isActive = isActive;
        }
        return e;
      }).toList();
      LocalDataManager.saveStringData("notifys", jsonEncode(_notifies));
    }
  }

  void editNotify(String identifier, Map<String, int> data) {
    _notifies = _notifies.map<NotifyModel>((e) {
      if (e.identifier == identifier) {
        e.hour = data['hour'] ?? 0;
        e.minute = data['minute'];
      }
      return e;
    }).toList();
    LocalDataManager.saveStringData("notifys", jsonEncode(_notifies));
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> _initializeNotification() async {
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notification) {
        switch (notification.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            onDidReceivedNotificationResponse(notification);
            break;
          case NotificationResponseType.selectedNotificationAction:
            break;
        }
      },
    );
  }

  void onDidReceivedNotificationResponse(NotificationResponse notification) {
    final id = notification.id;
    if (id == null) {
      return;
    }

    final localNotify = isLocalNotify(id);

    if (localNotify) {
      final notify = _notifies[id];
      registerMessage(
        hour: notify.hour!,
        minutes: notify.minute!,
        id: id,
        title: notify.title!,
        message: notify.message!,
      );
    } else {
      removeNotify(id);
    }
  }

  Future<void> cancelAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> requestPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> registerRepeatMessage({
    required int id,
    required String title,
    required String message,
    required RepeatInterval repeatInterval,
  }) async {
    try {
      await _flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        message,
        repeatInterval,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'notify',
            'notify-repeat',
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(message),
          ),
          iOS: const DarwinNotificationDetails(
            badgeNumber: 1,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerMessage({
    required int hour,
    required int minutes,
    required int id,
    required String title,
    required String message,
    bool? repeat,
    int? year,
    int? month,
    int? day,
  }) async {
    try {
      await cancelNotification(id);
      tz.TZDateTime nextInstanceOfOneMinutes() {
        final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
        tz.TZDateTime scheduledDate = tz.TZDateTime(
          tz.local,
          year ?? now.year,
          month ?? now.month,
          day ?? now.day,
          hour,
          minutes,
        );
        if (repeat ?? true && scheduledDate.isBefore(now)) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }
        return scheduledDate;
      }

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        message,
        nextInstanceOfOneMinutes(),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'notify',
            'notify-schedule',
            importance: Importance.max,
            priority: Priority.high,
            ongoing: true,
            styleInformation: BigTextStyleInformation(message),
          ),
          iOS: const DarwinNotificationDetails(
            badgeNumber: 1,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      rethrow;
    }
  }

  bool isLocalNotify(int id) {
    return !localNotifies.every((e) => e.id != id);
  }
}
