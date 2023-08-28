import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBody extends StatelessWidget {
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final DateTime selectedDay;
  Function(DateTime, DateTime)? onDaySelected;
  Function(CalendarFormat)? onFormatChange;
  Function(DateTime)? onPageChange;
  List<dynamic> Function(DateTime)? eventLoader;

  CalendarBody({
    super.key,
    required this.focusedDay,
    required this.calendarFormat,
    required this.selectedDay,
    this.onDaySelected,
    this.onFormatChange,
    this.onPageChange,
    this.eventLoader,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: "ko_KR",
      firstDay: DateTime(focusedDay.year, 1, 1),
      lastDay: DateTime(focusedDay.year + 10, 1, 1),
      focusedDay: focusedDay,
      calendarFormat: calendarFormat,
      eventLoader: eventLoader,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: onDaySelected,
      onFormatChanged: onFormatChange,
      onPageChanged: onPageChange,
    );
  }
}
