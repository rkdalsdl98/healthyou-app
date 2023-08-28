import 'package:flutter/material.dart';
import 'package:healthyou_app/design/dimensions.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/widget/global/rounded_icon_button_large.dart';
import 'package:provider/provider.dart';

import '../../global/help_text_dialog.dart';
import '../../global/rounded_button_medium.dart';
import 'history/meal_history.dart';
import 'meal_presets.dart';
import 'nutrition.dart';

class Meal extends StatelessWidget {
  const Meal({super.key});

  void showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const HelpTextDialog(
        texts: [
          "식사체크는 순서대로만 가능합니다.",
          "식사를 했을 경우 체크표시를, 하지 못했을 경우 엑스표시를 눌러주세요.",
        ],
        title: "도움말",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MealProvider>(
      builder: (_, provider, __) {
        final state = provider.state;
        final totalNutrients = provider.totalNutrients;
        final presets = provider.presets;
        return state == MealState.empty
            ? defaultHelper(context)
            : Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: RoundedButtonMedium(
                              text: "도움말",
                              onPressEvent: () => showHelpDialog(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nutrition(totalNutrients: totalNutrients),
                    MealPresets(presets: presets),
                    const MealHistory(),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: RoundedButtonMedium(
                            text: "수정하기",
                            onPressEvent: () =>
                                Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/register-meal',
                              (_) => false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

Widget defaultHelper(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Align(
        alignment: Alignment.center,
        child: RoundedIconButtonLarge(
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
            size: 32 * getScaleFactorFromWidth(context),
          ),
          onPressEvent: () => Navigator.pushNamed(context, '/register-meal'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          "아직 등록한 식사 루틴이 없으시군요?\n+버튼을 눌러 나만의 식사 루틴을 저장할 수 있습니다!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
            fontSize: 10 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
      ),
    ],
  );
}
