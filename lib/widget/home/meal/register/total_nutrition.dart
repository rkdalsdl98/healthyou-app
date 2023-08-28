import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:provider/provider.dart';

import '../../../../design/dimensions.dart';
import '../../../../system/unit_system.dart';

class TotalNutrition extends StatelessWidget {
  const TotalNutrition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 160 * getScaleFactorFromWidth(context),
            height: 140 * getScaleFactorFromWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
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
            ),
            child: Consumer<MealProvider>(
              builder: (_, provider, __) {
                final nutrients = provider.totalNutrients;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '하루 섭취 영양',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 14 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text:
                            "탄수화물 : ${addCommas(nutrients.totalCarbohydrate)} g\n",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 12 * getScaleFactorFromWidth(context),
                          fontFamily: 'SpoqaHanSans',
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                          height: 2,
                        ),
                        children: [
                          TextSpan(
                              text:
                                  "단백질 : ${addCommas(nutrients.totalProtein)} g\n"),
                          TextSpan(
                              text:
                                  "지방 : ${addCommas(nutrients.totalFat)} g\n"),
                          TextSpan(
                              text:
                                  "칼로리 : ${addCommas(nutrients.totalCalorie)} kcal"),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 170 * getScaleFactorFromWidth(context),
            height: 80 * getScaleFactorFromWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
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
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: "1. +버튼을 눌러 식사를 최대 10개 까지 추가할 수 있습니다.\n",
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.5),
                    fontSize: 6 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w600,
                    height: 2,
                  ),
                  children: const [
                    TextSpan(text: "2. 작성중인 프리셋을 좌,우로 드래그 하여 넘길 수 있습니다.\n"),
                    TextSpan(text: "3. 수정하고 싶은 칸을 터치하면 수정창이 열립니다.\n"),
                    TextSpan(text: "4. 식사 횟수를 변경 할 경우, 작성한 내용이 초기화 됩니다.\n"),
                    TextSpan(
                        text: "5. 상단에 숫자를 변경해 먹을 식사 횟수를 정할 수 있습니다.\n(최대 9회)"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
