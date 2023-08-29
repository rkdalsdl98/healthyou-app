import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/widget/global/rounded_button_medium.dart';
import 'package:healthyou_app/widget/home/meal/register/register_meal_preset_pageview.dart';
import 'package:provider/provider.dart';

import '../../design/dimensions.dart';
import '../../widget/home/meal/register/meal_count_box.dart';
import '../../widget/home/meal/register/total_nutrition.dart';

class RegisterMeal extends StatefulWidget {
  const RegisterMeal({super.key});

  @override
  State<RegisterMeal> createState() => _RegisterMealState();
}

class _RegisterMealState extends State<RegisterMeal> {
  int currIndex = 0;
  int len = 1;

  void setPageLen(int newLen) => setState(() {
        len = newLen;
      });

  @override
  void initState() {
    super.initState();
    final currLen = context.read<MealProvider>().presets.length;
    len = currLen < 1 ? 1 : currLen;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Future<bool>.value(false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: CustomScrollView(
            slivers: [
              MealCountBox(
                onChangeLen: setPageLen,
                currLen: len,
              ),
              RegisterMealPresetPageView(currLen: len),
              const TotalNutrition(),
              const BottomWrapper(),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomWrapper extends StatelessWidget {
  const BottomWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MealProvider>();
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButtonMedium(
                text: "저장",
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  bottom: 10,
                  top: 40,
                ),
                onPressEvent: () {
                  provider.savePresets();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (_) => false,
                  );
                },
              ),
              RoundedButtonMedium(
                text: "초기화",
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  bottom: 10,
                  top: 40,
                ),
                onPressEvent: () => provider.clearPresets(),
              ),
            ],
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "식사 루틴은 최대 1개만 등록이 가능합니다.\n",
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              children: const [
                TextSpan(text: "식사 루틴은 프로필에 표시되는 일수에 포함되지 않습니다."),
              ],
            ),
          )
        ],
      ),
    );
  }
}
