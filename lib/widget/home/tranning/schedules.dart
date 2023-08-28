import 'package:flutter/material.dart';
import 'package:healthyou_app/model/traning/traning_schedule_model.dart';
import 'package:healthyou_app/system/message_system.dart';
import 'package:healthyou_app/widget/home/tranning/schedule_dialog.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../../provider/traning_provider.dart';
import '../../../types/date_types.dart';
import '../../global/scale_anim_icon.dart';

class Schedules extends StatelessWidget {
  const Schedules({
    super.key,
  });

  void showAlreadyIsScheduleMessage(BuildContext context) {
    MessageSystem.initSnackBarMessage(
      context,
      MessageIconTypes.NULL,
      message: "오늘은 운동을 이미 마치셨군요?",
    );
  }

  void showScheduleDialog(
    BuildContext context,
    TraningScheduleModel? schedule,
  ) {
    if (schedule == null) {
      MessageSystem.initSnackBarMessage(
        context,
        MessageIconTypes.NULL,
        message: "유효하지 않은 스케쥴 입니다",
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) {
        return ScheduleDialog(daily: schedule.daily!);
      },
    );
  }

  void moveToDetail(
    BuildContext context,
    TraningScheduleModel? schedule,
  ) {
    try {
      if (schedule == null) {
        MessageSystem.initSnackBarMessage(
          context,
          MessageIconTypes.NULL,
          message: "유효하지 않은 스케쥴 입니다",
        );
        return;
      }

      final provider = context.read<TraningProvider>();
      final validPreset =
          provider.isValidPresetByIndex(schedule.schedule!.index!);

      if (!validPreset) {
        provider.removePreset(schedule.schedule!.index!);
        provider.removeSchedule(schedule.daily!);
        MessageSystem.initSnackBarMessage(
          context,
          MessageIconTypes.NULL,
          message: "존재하지 않는 프리셋이 적용된 것이 확인되어 삭제했습니다",
        );
        return;
      }
      Navigator.pushNamedAndRemoveUntil(
          context, "/schedule-detail", (route) => false,
          arguments: schedule.toJson());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TraningProvider>(builder: (_, provider, __) {
      final schedules = provider.schedules;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              weekScheduleHelper(context, schedule: schedules['monday']),
              weekScheduleHelper(context, schedule: schedules['tuesday']),
              weekScheduleHelper(context, schedule: schedules['wednesday']),
              weekScheduleHelper(context, schedule: schedules['thursday']),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              weekScheduleHelper(context, schedule: schedules['friday']),
              weekScheduleHelper(context, schedule: schedules['saturday']),
              weekScheduleHelper(context, schedule: schedules['sunday']),
            ],
          ),
        ],
      );
    });
  }

  Widget weekScheduleHelper(
    BuildContext context, {
    TraningScheduleModel? schedule,
  }) {
    return InkWell(
      onTap: () => schedule?.schedule != null
          ? (schedule?.state == "idle"
              ? moveToDetail(context, schedule)
              : showAlreadyIsScheduleMessage(context))
          : showScheduleDialog(
              context,
              schedule,
            ),
      child: Column(
        children: [
          if (DateTypes.DAYS[DateTime.now().weekday] == schedule?.daily)
            Text(
              'Today!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 6 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w600,
                height: 2,
              ),
            ),
          Container(
            width: 50 * getScaleFactorFromWidth(context),
            height: 100 * getScaleFactorFromHeight(context),
            decoration: BoxDecoration(
              color: DateTypes.DAYS[DateTime.now().weekday] == schedule?.daily
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.25),
                )
              ],
              borderRadius: BorderRadius.circular(180),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  schedule?.daily == null
                      ? "null"
                      : schedule!.daily!.toUpperCase(),
                  style: TextStyle(
                    color: DateTypes.DAYS[DateTime.now().weekday] ==
                            schedule?.daily
                        ? Theme.of(context).colorScheme.onTertiary
                        : Theme.of(context).colorScheme.onBackground,
                    fontSize: 6 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w600,
                    height: 2,
                  ),
                ),
                Text(
                  schedule?.schedule == null
                      ? "+"
                      : "${schedule?.schedule?.name}",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: DateTypes.DAYS[DateTime.now().weekday] ==
                            schedule?.daily
                        ? Theme.of(context).colorScheme.onTertiary
                        : Theme.of(context).colorScheme.onBackground,
                    fontSize: 8 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w600,
                    height: 2,
                  ),
                ),
                if (schedule?.state != "idle")
                  ScaleAnimIcon(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(seconds: 1),
                    size: 12,
                    icon: schedule?.state == "done" ? Icons.check : Icons.close,
                    color: schedule?.state == "done"
                        ? const Color(0xFF1CBA3E)
                        : Theme.of(context).colorScheme.error,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
