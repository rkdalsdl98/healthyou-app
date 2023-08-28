import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/widget/home/meal/register/register_meal_column.dart';
import 'package:provider/provider.dart';

import '../../../../design/dimensions.dart';

class RegisterMealPresetPageView extends StatefulWidget {
  final int currLen;

  const RegisterMealPresetPageView({
    super.key,
    required this.currLen,
  });

  @override
  State<RegisterMealPresetPageView> createState() =>
      _RegisterMealPresetPageViewState();
}

class _RegisterMealPresetPageViewState
    extends State<RegisterMealPresetPageView> {
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            width: 340 * getScaleFactorFromWidth(context),
            height: 340 * getScaleFactorFromWidth(context),
            margin: const EdgeInsets.symmetric(vertical: 5),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                )
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Consumer<MealProvider>(builder: (_, provider, __) {
              final presets = provider.presets;
              return PageView.builder(
                onPageChanged: (value) => setState(() {
                  currIndex = value;
                }),
                itemCount: widget.currLen,
                itemBuilder: (_, index) => RegisterMealColumn(
                  index: index,
                  presetInfos: presets[index],
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${currIndex + 1} / ${widget.currLen}",
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.2),
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
