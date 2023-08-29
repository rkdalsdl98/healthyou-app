import 'package:flutter/material.dart';
import 'package:healthyou_app/design/dimensions.dart';
import 'package:healthyou_app/provider/calendar_provider.dart';
import 'package:healthyou_app/widget/global/rounded_button_medium.dart';
import 'package:healthyou_app/widget/home/calendar/add_memo_dialog.dart';
import 'package:healthyou_app/widget/home/calendar/calendar_body.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/calendar/event_model.dart';
import '../../global/help_text_dialog.dart';
import 'calendar_memo.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  Map<String, List<EventModel>> events = {};

  void onFormatChange(CalendarFormat format) {
    if (calendarFormat != format) {
      setState(() {
        calendarFormat = format;
      });
    }
  }

  void onPageChange(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
  }

  void onDaySelected(DateTime newSelectedDay, DateTime newFocusedDay) {
    if (!isSameDay(selectedDay, newSelectedDay)) {
      setState(() {
        final provider = context.read<CalendarProvider>();
        selectedDay = newSelectedDay;
        focusedDay = newFocusedDay;

        final event = getEvent(selectedDay!);
        provider.setSelectedEvents(event);
      });
    }
  }

  void onSaveMemo(String text) {
    final provider = context.read<CalendarProvider>();
    provider.addEvent({
      "text": text,
      "notifyDate": selectedDay.toString(),
    });

    provider.setSelectedEvents(getEvent(selectedDay!));
    setState(() {});
  }

  void showAddMemoDialog() {
    showDialog(
      context: context,
      builder: (_) => AddMemoDialog(
        title: "메모",
        onSaveData: onSaveMemo,
      ),
    );
  }

  void onRemoveMemo(DateTime date, int order) {
    final provider = context.read<CalendarProvider>();
    provider.removeEvent(date, order);
    setState(() {});
  }

  List<EventModel> getEvent(DateTime date) {
    return events["${date.year}:${date.month}:${date.day}"] ?? [];
  }

  void showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const HelpTextDialog(
        texts: [
          "메모를 삭제 할 경우, 등록된 알림도 함께 삭제됩니다.",
          "알림을 받은 이후에도 알림 삭제로 표기 되는 경우,\n표기만 삭제로 나오고 받은 알림은 삭제된 상태입니다.",
          "알림은 당일 0시 0분에 1회 받을 수 있습니다."
        ],
        title: "도움말",
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    selectedDay = focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(builder: (_, provider, __) {
      final selectedEvents = provider.selectedEvents;
      events = provider.events;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CalendarBody(
              selectedDay: selectedDay!,
              focusedDay: focusedDay,
              calendarFormat: calendarFormat,
              onDaySelected: onDaySelected,
              onFormatChange: onFormatChange,
              onPageChange: onPageChange,
              eventLoader: getEvent,
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemCount: selectedEvents.length,
                itemBuilder: (context, index) => CalendarMemo(
                  memo: selectedEvents[index],
                  notifyIndex: index + 1,
                  onRemoveMemo: onRemoveMemo,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundedButtonMedium(
                    text: "도움말",
                    onPressEvent: () => showHelpDialog(context),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  FloatingActionButton(
                    onPressed: showAddMemoDialog,
                    mini: true,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.add,
                      size: 18 * getScaleFactorFromWidth(context),
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
