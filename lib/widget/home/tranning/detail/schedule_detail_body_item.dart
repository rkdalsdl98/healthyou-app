import 'package:flutter/material.dart';
import 'package:healthyou_app/model/traning/cardio_traning_preset_model.dart';
import 'package:healthyou_app/model/traning/weight_traning_preset_model.dart';

import '../../../../design/dimensions.dart';

class ScheduleDetailBodyItem extends StatefulWidget {
  dynamic item;
  final Function() onComplete;
  final Function() onUnComplete;

  ScheduleDetailBodyItem({
    super.key,
    this.item,
    required this.onComplete,
    required this.onUnComplete,
  });

  @override
  State<ScheduleDetailBodyItem> createState() => _ScheduleDetailBodyItemState();
}

class _ScheduleDetailBodyItemState extends State<ScheduleDetailBodyItem> {
  bool isComplete = false;
  String? identifier;
  late Widget itemList;

  @override
  Widget build(BuildContext context) {
    if (identifier == null) {
      identifier = widget.item['identifier'];
      if (identifier == "무산소") {
        widget.item = WeightTraningPresetModel.fromJson(widget.item);
        itemList = weightPresetHelper(context, widget.item);
      } else {
        widget.item = CardioTraningPresetModel.fromJson(widget.item);
        itemList = cardioPresetHelper(context, widget.item);
      }
      isComplete = widget.item.isDone;
    }

    return Container(
      height: 40 * getScaleFactorFromHeight(context),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              children: [
                itemList,
              ],
            ),
          ),
          Checkbox(
            value: isComplete,
            onChanged: (v) => setState(() {
              isComplete = v!;
              if (isComplete) {
                widget.onComplete();
              } else {
                widget.onUnComplete();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget weightPresetHelper(
      BuildContext context, WeightTraningPresetModel preset) {
    var seconds = preset.restTime;
    String restTime = "";
    if (seconds != null) {
      seconds = seconds;
      var minute = seconds ~/ 60;
      seconds -= minute * 60;
      restTime =
          "${minute < 1 ? "" : "$minute분 "}${seconds < 1 ? "" : "$seconds초"}";
    }
    return Row(
      children: [
        presetItemHelper(context, "${preset.identifier}"),
        presetItemHelper(context, "${preset.machine}", width: 50),
        presetItemHelper(context, "${preset.machineWeight} kg"),
        presetItemHelper(context, "${preset.count}회"),
        presetItemHelper(context, "${preset.totalSet}회"),
        presetItemHelper(context, restTime, width: 45),
      ],
    );
  }

  Widget cardioPresetHelper(
      BuildContext context, CardioTraningPresetModel preset) {
    var seconds = preset.restTime;
    String restTime = "";
    if (seconds != null) {
      seconds = seconds;
      var minute = seconds ~/ 60;
      seconds -= minute * 60;
      restTime =
          "${minute < 1 ? "" : "$minute분 "}${seconds < 1 ? "" : "$seconds초"}";
    }
    return Row(
      children: [
        presetItemHelper(context, "${preset.identifier}"),
        presetItemHelper(context, "${preset.machine}", width: 50),
        presetItemHelper(context, "${preset.distance} km"),
        presetItemHelper(context, restTime, width: 45),
      ],
    );
  }

  Widget presetItemHelper(
    BuildContext context,
    String info, {
    double? width,
  }) {
    return SizedBox(
      width: (width ?? 40) * getScaleFactorFromWidth(context),
      child: Center(
        child: Text(
          info,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 9 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
