import 'package:flutter/material.dart';
import 'package:healthyou_app/model/meal/meal_preset_model.dart';

import '../../../design/dimensions.dart';
import 'meal_preset.dart';

class MealPresets extends StatelessWidget {
  final Map<int, List<MealPresetModel>> presets;

  const MealPresets({
    super.key,
    required this.presets,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: 280 * getScaleFactorFromWidth(context),
        height: 220 * getScaleFactorFromWidth(context),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(.25),
              offset: const Offset(0, 4),
              blurRadius: 4,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: PageView.builder(
          itemBuilder: (_, index) => MealPreset(
            index: index,
            preset: presets[index],
          ),
          itemCount: presets.length,
        ),
      ),
    );
  }
}
