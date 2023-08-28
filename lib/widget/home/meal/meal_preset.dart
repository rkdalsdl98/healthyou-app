import 'package:flutter/material.dart';
import 'package:healthyou_app/model/meal/meal_preset_model.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/system/message_system.dart';
import 'package:healthyou_app/widget/global/scale_anim_icon.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../global/rounded_icon_button.medium.dart';
import 'meal_preset_item.dart';

class MealPreset extends StatelessWidget {
  final int index;
  List<MealPresetModel>? preset;

  MealPreset({
    super.key,
    required this.index,
    required this.preset,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MealProvider>();

    void onAddHistory(bool res) {
      try {
        final now = DateTime.now();
        final time = "${now.hour}:${now.minute}";

        provider.addHistory({
          "time": time,
          "index": index,
          "result": res,
        }, res);
      } catch (e) {
        if (e.toString().contains("PrevIsNotCheck")) {
          MessageSystem.initSnackBarMessage(
            context,
            MessageIconTypes.NULL,
            message: "이전 식사를 먼저 체크 해주세요!",
          );
        }
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            '${index + 1} 번째 식사',
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
            child: Column(
              children: [
                for (var item in preset ?? [])
                  MealPresetItem(food: item.food, count: item.count)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Consumer<MealProvider>(builder: (_, provider, __) {
            final state = provider.presetsStates["$index"];

            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (state != "idle")
                  ScaleAnimIcon(
                    curve: Curves.linearToEaseOut,
                    duration: const Duration(seconds: 1),
                    size: 18,
                    icon: state == "done" ? Icons.check : Icons.close,
                    color: state == "done"
                        ? const Color(0xFF1CBA3E)
                        : Theme.of(context).colorScheme.error,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                if (state == "idle")
                  Wrap(
                    children: [
                      RoundedIconButtonMedium(
                        icon: Icon(
                          Icons.check,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.5),
                          size: 12 * getScaleFactorFromWidth(context),
                        ),
                        onPressEvent: () => onAddHistory(true),
                      ),
                      RoundedIconButtonMedium(
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.5),
                          size: 12 * getScaleFactorFromWidth(context),
                        ),
                        onPressEvent: () => onAddHistory(false),
                      ),
                    ],
                  ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
