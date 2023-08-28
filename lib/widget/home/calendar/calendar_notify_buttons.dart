import 'package:flutter/material.dart';
import 'package:healthyou_app/system/message_system.dart';
import 'package:healthyou_app/system/unit_system.dart';
import 'package:provider/provider.dart';

import '../../../provider/notify_provider.dart';
import '../../global/rounded_button_medium.dart';

class CalendarNotifyButtons extends StatelessWidget {
  final int notifyIndex;
  final Function(DateTime date, int order) onRemoveMemo;
  final DateTime notifyDate;
  final int order;
  final String message;

  const CalendarNotifyButtons({
    super.key,
    required this.notifyIndex,
    required this.onRemoveMemo,
    required this.notifyDate,
    required this.order,
    required this.message,
  });

  void addNotify(BuildContext context) {
    final provider = context.read<NotifyProvider>();
    try {
      provider.registerMessage(
        (notifyIndex * 10),
        message: message,
        title: "오늘은 이런 일이 있어요!",
        repeat: false,
        year: notifyDate.year,
        month: notifyDate.month,
        day: notifyDate.day,
        hour: 0,
        minutes: 0,
      );
      MessageSystem.initSnackBarMessage(
        context,
        MessageIconTypes.DONE,
        message: "성공적으로 알림을 등록했습니다.",
      );
    } catch (e) {
      MessageSystem.initSnackBarErrorMessage(
        context,
        message: "알 수 없는 이유로 알림 등록에 실패했습니다.",
        error: e.toString(),
      );
    }
  }

  void removeNotify(BuildContext context) {
    final provider = context.read<NotifyProvider>();
    provider.removeNotify((notifyIndex * 10));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotifyProvider>(builder: (_, provider, __) {
      final notify = provider.getCalendarNotifyById((notifyIndex * 10));

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedButtonMedium(
            text: "메모 삭제",
            margin: const EdgeInsets.only(bottom: 5),
            onPressEvent: () => onRemoveMemo(
              notifyDate,
              order,
            ),
          ),
          RoundedButtonMedium(
            text: notify == null ? "알림 받기" : "알림 삭제",
            margin: const EdgeInsets.only(top: 5),
            onPressEvent: () =>
                notify == null ? addNotify(context) : removeNotify(context),
          ),
        ],
      );
    });
  }
}
