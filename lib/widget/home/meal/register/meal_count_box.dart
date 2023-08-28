import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/system/message_system.dart';
import 'package:provider/provider.dart';

import '../../../../design/dimensions.dart';
import '../../../../system/validate_system.dart';
import '../../../../types/validate_types.dart';

class MealCountBox extends StatefulWidget {
  final Function(int) onChangeLen;
  int currLen;

  MealCountBox({
    super.key,
    required this.onChangeLen,
    required this.currLen,
  });

  @override
  State<MealCountBox> createState() => _MealCountBoxState();
}

class _MealCountBoxState extends State<MealCountBox> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: 70 * getScaleFactorFromWidth(context),
          height: 45 * getScaleFactorFromWidth(context),
          clipBehavior: Clip.hardEdge,
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
            borderRadius: BorderRadius.circular(15),
          ),
          child: Consumer<MealProvider>(builder: (_, provider, __) {
            return inputHelper(
              context,
              "meal-count",
              hintText: "식사 횟수",
              maxLength: 1,
              intialValue: "${widget.currLen}",
              inputType: TextInputType.number,
              onSubmit: (value) {
                if (value != null && value.isNotEmpty) {
                  if (match(value, ValidateType.number)) {
                    final len = int.parse(value);
                    context.read<MealProvider>().changePresetsLen(len - 1);
                    widget.onChangeLen(len);
                    return;
                  }
                  MessageSystem.initSnackBarMessage(
                    context,
                    MessageIconTypes.NULL,
                    message: "숫자외에 다른 값은 입력할 수 없습니다",
                  );
                  return;
                }
                MessageSystem.initSnackBarMessage(
                  context,
                  MessageIconTypes.NULL,
                  message: "공백은 입력할 수 없습니다",
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

Widget inputHelper(
  BuildContext context,
  String key, {
  int? maxLength,
  TextInputType? inputType,
  String? hintText,
  double? width,
  Function(String?)? onSubmit,
  String? intialValue,
}) {
  return SizedBox(
    width: (width ?? 40) * getScaleFactorFromWidth(context),
    child: TextFormField(
      initialValue: intialValue,
      onFieldSubmitted: onSubmit,
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      maxLength: maxLength ?? 10,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 12 * getScaleFactorFromWidth(context),
        fontFamily: 'SpoqaHanSans',
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
        counterText: "",
        counterStyle: const TextStyle(height: double.minPositive),
        border: InputBorder.none,
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFFE94251),
          ),
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
          fontSize: 12 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
        hintText: hintText,
      ),
    ),
  );
}
