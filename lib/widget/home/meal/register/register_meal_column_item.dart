import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/system/unit_system.dart';
import 'package:healthyou_app/widget/home/meal/register/edit_register_meal_column_item.dart';
import 'package:provider/provider.dart';

import '../../../../design/dimensions.dart';

class RegisterMealColumnItem extends StatefulWidget {
  final int index;
  final int order;
  String? food;
  int? count;
  int? protein;
  int? carbohydrate;
  int? calorie;
  int? fat;

  RegisterMealColumnItem({
    super.key,
    this.food,
    this.count,
    this.protein,
    this.carbohydrate,
    this.fat,
    this.calorie,
    required this.index,
    required this.order,
  });

  @override
  State<RegisterMealColumnItem> createState() => _RegisterMealColumnItemState();
}

class _RegisterMealColumnItemState extends State<RegisterMealColumnItem> {
  void edit(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => ChangeNotifierProvider<MealProvider>.value(
        value: context.read<MealProvider>(),
        child: RegisterMealDialog(
          fat: widget.fat,
          food: widget.food,
          calorie: widget.calorie,
          carbohydrate: widget.carbohydrate,
          count: widget.count,
          protein: widget.protein,
          index: widget.index,
          order: widget.order,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontSize: 10 * getScaleFactorFromWidth(context),
      fontFamily: 'SpoqaHanSans',
      fontWeight: FontWeight.w500,
    );

    return InkWell(
      onTap: () => edit(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40 * getScaleFactorFromWidth(context),
              height: 30 * getScaleFactorFromWidth(context),
              child: Center(
                child: Text(
                  widget.food ?? "",
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
                  "${widget.count ?? ""} 개",
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
                  "${widget.carbohydrate ?? ""} g",
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
                  "${widget.protein ?? ""} g",
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
                  "${widget.fat ?? ""} g",
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
                  "${addCommas((widget.calorie ?? 0))} kcal",
                  textAlign: TextAlign.center,
                  style: style,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
