import 'package:flutter/material.dart';
import 'package:healthyou_app/model/traning/cardio_traning_preset_model.dart';
import 'package:healthyou_app/model/traning/weight_traning_preset_model.dart';

import '../../../design/dimensions.dart';

class PresetItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const PresetItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final identifier = item['identifier'];

    return Container(
      margin: EdgeInsets.only(top: 5 * getScaleFactorFromWidth(context)),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 30 * getScaleFactorFromHeight(context),
      child: identifier == null
          ? const SizedBox()
          : (identifier == "무산소"
              ? weightHelper(context, WeightTraningPresetModel.fromJson(item))
              : cardioHelper(context, CardioTraningPresetModel.fromJson(item))),
    );
  }

  Widget weightHelper(
    BuildContext context,
    WeightTraningPresetModel weightPreset,
  ) {
    var seconds = weightPreset.restTime;
    String restTime = "";
    if (seconds != null) {
      var minute = seconds ~/ 60;
      seconds -= minute * 60;
      restTime =
          "${minute < 1 ? "" : "$minute 분 "}${seconds < 1 ? "" : "$seconds 초"}";
    }
    return Row(
      children: [
        SizedBox(
          width: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              weightPreset.identifier ?? "Empty",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              weightPreset.machine ?? "Empty",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              "${weightPreset.machineWeight ?? 0} kg",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              "${weightPreset.count ?? 0} 회",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              "${weightPreset.totalSet ?? 0} 회",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              restTime,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cardioHelper(
    BuildContext context,
    CardioTraningPresetModel cardioPreset,
  ) {
    var seconds = cardioPreset.restTime;
    String restTime = "";
    if (seconds != null) {
      var minute = seconds ~/ 60;
      seconds -= minute * 60;
      restTime =
          "${minute < 1 ? "" : "$minute 분 "}${seconds < 1 ? "" : "$seconds 초"}";
    }
    return Row(
      children: [
        SizedBox(
          width: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              cardioPreset.identifier ?? "Empty",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              cardioPreset.machine ?? "Empty",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              "${cardioPreset.distance ?? 0} km",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              restTime,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const Spacer(flex: 6)
      ],
    );
  }
}
