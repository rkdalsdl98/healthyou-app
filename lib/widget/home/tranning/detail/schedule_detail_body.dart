import 'package:flutter/material.dart';
import 'package:healthyou_app/model/traning/traning_preset_model.dart';
import 'package:healthyou_app/widget/global/rounded_icon_button.medium.dart';
import 'package:healthyou_app/widget/home/tranning/detail/schedule_detail_body_item.dart';

import '../../../../design/dimensions.dart';
import '../../../global/helper_text_box.dart';
import '../../../global/rounded_icon_button_small.dart';
import '../schedule_dialog.dart';

class ScheduleDetailBody extends StatefulWidget {
  TraningPreset preset;
  final String daily;
  final Function() onComplete;
  final Function() onUnComplete;

  ScheduleDetailBody({
    super.key,
    required this.preset,
    required this.daily,
    required this.onComplete,
    required this.onUnComplete,
  });

  @override
  State<ScheduleDetailBody> createState() => _ScheduleDetailBodyState();
}

class _ScheduleDetailBodyState extends State<ScheduleDetailBody> {
  double helperBoxOpacity = 0;
  void setHelperBoxOpacity(bool isShowing) {
    setState(() {
      if (isShowing) {
        helperBoxOpacity = 1;
      } else {
        helperBoxOpacity = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.preset.presetItems ??= [];
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        width: 300 * getScaleFactorFromWidth(context),
        height: 300 * getScaleFactorFromWidth(context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(.25),
              offset: const Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ScheduleDetailHeader(
                    onPressQuestionButton: setHelperBoxOpacity,
                    name: widget.preset.name!,
                    daily: widget.daily,
                  ),
                  for (var item in widget.preset.presetItems!)
                    ScheduleDetailBodyItem(
                      item: item,
                      onComplete: widget.onComplete,
                      onUnComplete: widget.onUnComplete,
                    )
                ],
              ),
            ),
            Positioned(
              right: 40 * getScaleFactorFromWidth(context),
              top: 40 * getScaleFactorFromHeight(context),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                opacity: helperBoxOpacity,
                child: HelperTextBox(
                  width: 120,
                  text:
                      "모두 채우지 않아도 완료 버튼으로 오늘의 일과를 끝낼 수 있습니다.\n\n혹여 도중에 어플이 종료 되거나 해당 페이지를 떠나도 현재 진행 상황은 저장됩니다.",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleDetailHeader extends StatelessWidget {
  final Function(bool) onPressQuestionButton;
  final String name;
  final String daily;

  const ScheduleDetailHeader({
    super.key,
    required this.onPressQuestionButton,
    required this.name,
    required this.daily,
  });

  void showScheduleDialog(BuildContext context, String daily) {
    showDialog(
      context: context,
      builder: (_) {
        return ScheduleDialog(daily: daily);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40 * getScaleFactorFromHeight(context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          RoundedIconButtonMedium(
            icon: Icon(
              Icons.edit,
              color: const Color(0xFF93969F),
              size: 12 * getScaleFactorFromWidth(context),
            ),
            onPressEvent: () => showScheduleDialog(context, daily),
          ),
          RoundedIconButtonMedium(
            icon: Icon(
              Icons.question_mark,
              color: const Color(0xFF93969F),
              size: 12 * getScaleFactorFromWidth(context),
            ),
            onLongPressDown: () => onPressQuestionButton(true),
            onLongPressUp: () => onPressQuestionButton(false),
          ),
        ],
      ),
    );
  }
}
