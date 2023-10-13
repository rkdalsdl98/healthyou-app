import 'package:flutter/material.dart';
import 'package:healthyou_app/model/meal/meal_preset_model.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/system/message_system.dart';
import 'package:healthyou_app/widget/home/meal/register/register_meal_column_item.dart';
import 'package:provider/provider.dart';

import '../../../../design/dimensions.dart';
import '../../../global/rounded_icon_button.medium.dart';

class RegisterMealColumn extends StatelessWidget {
  final int index;
  List<MealPresetModel>? presetInfos;

  RegisterMealColumn({
    super.key,
    required this.index,
    required this.presetInfos,
  });

  @override
  Widget build(BuildContext context) {
    presetInfos = presetInfos ?? [];
    return ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1} 번째 식사",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 12 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RoundedIconButtonMedium(
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.5),
                      size: 12 * getScaleFactorFromWidth(context),
                    ),
                    onPressEvent: () {
                      try {
                        final provider = context.read<MealProvider>();
                        provider.addPresetInfo(
                          {
                            'food': "비어있음",
                            'count': 0,
                            'carbohydrate': 0,
                            'protein': 0,
                            'fat': 0,
                            'calorie': 0,
                            'index': index,
                          },
                        );
                      } catch (e) {
                        if (e.toString().contains("RangeOverException")) {
                          MessageSystem.initSnackBarMessage(
                            context,
                            MessageIconTypes.NULL,
                            message: "등록할 수 있는 범위를 초과 했습니다!",
                          );
                        }
                      }
                    },
                  )
                ],
              ),
            ),
            categoryHelper(
              context,
              item1: "음식",
              item2: "개수",
              item3: "탄수화물",
              item4: "단백질",
              item5: "지방",
              item6: "칼로리",
            ),
            for (var info in presetInfos!)
              RegisterMealColumnItem(
                food: info.food,
                count: info.count,
                calorie: info.calorie,
                carbohydrate: info.carbohydrate,
                fat: info.fat,
                protein: info.protein,
                index: info.index!,
                order: info.order!,
              ),
          ],
        ),
      ],
    );
  }
}

Widget categoryHelper(
  BuildContext context, {
  String? item1,
  String? item2,
  String? item3,
  String? item4,
  String? item5,
  String? item6,
}) {
  TextStyle style = TextStyle(
    color: Theme.of(context).colorScheme.onBackground,
    fontSize: 10 * getScaleFactorFromWidth(context),
    fontFamily: 'SpoqaHanSans',
    fontWeight: FontWeight.w500,
  );

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          height: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              item1 ?? "",
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ),
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          height: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              item2 ?? "",
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ),
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          height: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              item3 ?? "",
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ),
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          height: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              item4 ?? "",
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ),
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          height: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              item5 ?? "",
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ),
        SizedBox(
          width: 40 * getScaleFactorFromWidth(context),
          height: 30 * getScaleFactorFromWidth(context),
          child: Center(
            child: Text(
              item6 ?? "",
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        )
      ],
    ),
  );
}
