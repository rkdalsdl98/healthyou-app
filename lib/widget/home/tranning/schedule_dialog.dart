import 'package:flutter/material.dart';
import 'package:healthyou_app/model/traning/traning_preset_model.dart';
import 'package:healthyou_app/model/traning/traning_schedule_model.dart';
import 'package:healthyou_app/provider/traning_provider.dart';
import 'package:healthyou_app/system/message_system.dart';
import 'package:healthyou_app/widget/global/rounded_button_medium.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';

class ScheduleDialog extends StatefulWidget {
  final String daily;

  const ScheduleDialog({
    super.key,
    required this.daily,
  });

  @override
  State<ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  int? currIndex;
  TraningPreset? currPreset;

  void setSelItem(int? selIndex, TraningPreset? selPreset) {
    setState(() {
      currIndex = selIndex;
      currPreset = selPreset;
    });
  }

  void reset() {
    final provider = context.read<TraningProvider>();
    provider.resetSchedule(widget.daily);
  }

  void updateSchedule() {
    if (currIndex == null) return;

    try {
      final provider = context.read<TraningProvider>();
      provider.updateSchedule(
        widget.daily,
        currPreset == null
            ? TraningScheduleModel().toJson()
            : TraningScheduleModel(
                daily: widget.daily,
                schedule: currPreset,
              ).toJson(),
        currPreset: currPreset,
      );
    } catch (e) {
      if (e.toString().contains("PresetIsAlready")) {
        MessageSystem.initSnackBarMessage(
          context,
          MessageIconTypes.NULL,
          message: "이미 등록된 요일이 있습니다",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 130),
      child: Container(
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
        width: double.maxFinite,
        height: 200 * getScaleFactorFromWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                "목록",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<TraningProvider>(builder: (_, provider, __) {
                  final presets = provider.presets;
                  return Column(
                    children: [
                      for (var preset in presets)
                        presetListItemHelper(
                          context,
                          preset: preset,
                          index: preset.index,
                        ),
                    ],
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButtonMedium(
                  text: "등록",
                  margin: const EdgeInsets.all(5),
                  onPressEvent: () {
                    updateSchedule();
                    Navigator.pop(context);
                  },
                ),
                RoundedButtonMedium(
                  text: "초기화",
                  margin: const EdgeInsets.all(5),
                  onPressEvent: () {
                    reset();
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, "/home");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget presetListItemHelper(
    BuildContext context, {
    int? index,
    TraningPreset? preset,
  }) {
    final Color defaultColor = Theme.of(context).colorScheme.background;
    final Color selColor =
        Theme.of(context).colorScheme.onBackground.withOpacity(.1);

    return InkWell(
      onTap: () => setSelItem(index, preset),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: currIndex == null
              ? defaultColor
              : (currIndex == index ? selColor : defaultColor),
        ),
        child: Center(
          child: Text(
            preset?.name ?? "Empty",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 12 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
