import 'package:flutter/material.dart';
import 'package:healthyou_app/model/traning/traning_schedule_model.dart';
import 'package:healthyou_app/provider/timer_provider.dart';
import 'package:healthyou_app/provider/traning_provider.dart';
import 'package:healthyou_app/repository/timer_repository.dart';
import 'package:healthyou_app/widget/global/timer/custom_timer.dart';
import 'package:healthyou_app/widget/global/rounded_button_medium.dart';
import 'package:healthyou_app/widget/home/tranning/detail/schedule_detail_body.dart';
import 'package:provider/provider.dart';

import '../../design/dimensions.dart';
import '../../system/message_system.dart';
import '../../types/date_types.dart';
import '../../widget/global/rounded_icon_button.medium.dart';

class ScheduleDetail extends StatelessWidget {
  final TraningScheduleModel schedule;

  ScheduleDetail({
    super.key,
    required this.schedule,
  });

  int completes = 0;

  void notAvailableToday(BuildContext context) {
    MessageSystem.initSnackBarMessage(
      context,
      MessageIconTypes.NULL,
      message: "해당 요일의 운동만 사용이 가능합니다!",
    );
  }

  void showEndDialog(
    BuildContext context,
    String title,
    String message,
    Function(TraningProvider, String) save,
    String state,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 120),
        child: Container(
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Theme.of(context).colorScheme.shadow.withOpacity(.25),
              )
            ],
          ),
          height: 150 * getScaleFactorFromWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 10 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "확인 버튼을 누르면 홈 화면으로 넘어갑니다.",
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.5),
                    fontSize: 6 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: RoundedButtonMedium(
                  text: "확인",
                  onPressEvent: () {
                    saveSchedule(context.read<TraningProvider>(), state);
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, "/home");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveSchedule(TraningProvider provider, String newState) {
    schedule.setCompletes(completes);
    schedule.setState(newState);
    provider.updateSchedule(
      schedule.daily!,
      schedule.toJson(),
      currPreset: schedule.schedule,
    );
    provider.increaseAchievementDays();
  }

  void increaseCompletes() => ++completes;
  void decreaseCompletes() => --completes;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerProvider>(
      create: (_) => TimerProvider(repository: TimerRepository()),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, right: 20),
                      child: RoundedIconButtonMedium(
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.5),
                          size: 12 * getScaleFactorFromWidth(context),
                        ),
                        onPressEvent: () =>
                            Navigator.popAndPushNamed(context, "/home"),
                      ),
                    ),
                  ),
                  ScheduleDetailBody(
                    preset: schedule.schedule!,
                    daily: schedule.daily!,
                    onComplete: increaseCompletes,
                    onUnComplete: decreaseCompletes,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40, bottom: 40),
                      child: RoundedButtonMedium(
                        text: "완료",
                        onPressEvent: () {
                          if (DateTypes.DAYS[DateTime.now().weekday] !=
                              schedule.daily) {
                            notAvailableToday(context);
                            return;
                          }
                          final items = schedule.schedule!.presetItems;
                          if (items == null) {
                            Navigator.popAndPushNamed(context, "/home");
                          }

                          final newState =
                              schedule.schedule!.presetItems!.length <=
                                      completes
                                  ? "done"
                                  : "undone";

                          if (newState == "done") {
                            showEndDialog(
                              context,
                              "오운완!",
                              "오늘도 운동마친 당신은 보람찬 하루를 보낸겁니다!",
                              saveSchedule,
                              newState,
                            );
                          } else {
                            showEndDialog(
                              context,
                              "오-난",
                              "오늘도 운동한 당신은 보람찬 하루를 보낸겁니다!",
                              saveSchedule,
                              newState,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const CustomTimer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Text(
                      "타이머의 프리셋은 모든 곳에서 공통으로 사용되며, 최대 4개까지 등록이 가능합니다.",
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.5),
                        fontSize: 8 * getScaleFactorFromWidth(context),
                        fontFamily: 'SpoqaHanSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
