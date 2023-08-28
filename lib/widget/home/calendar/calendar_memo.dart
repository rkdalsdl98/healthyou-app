import 'package:flutter/material.dart';
import 'package:healthyou_app/model/calendar/event_model.dart';
import 'package:healthyou_app/widget/home/calendar/calendar_notify_buttons.dart';

import '../../../design/dimensions.dart';

class CalendarMemo extends StatelessWidget {
  final EventModel memo;
  final int notifyIndex;
  final Function(DateTime date, int order) onRemoveMemo;

  const CalendarMemo({
    super.key,
    required this.memo,
    required this.onRemoveMemo,
    required this.notifyIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100 * getScaleFactorFromWidth(context),
              child: Text(
                memo.text ?? "빈 메모",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.8),
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CalendarNotifyButtons(
              notifyIndex: notifyIndex,
              onRemoveMemo: onRemoveMemo,
              notifyDate: memo.notifyDate!,
              order: memo.order!,
              message: memo.text ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
