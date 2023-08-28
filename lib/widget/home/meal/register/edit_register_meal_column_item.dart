import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/widget/global/rounded_button_medium.dart';
import 'package:provider/provider.dart';

import '../../../../design/dimensions.dart';
import '../../../../system/validate_system.dart';
import '../../../../types/validate_types.dart';

class RegisterMealDialog extends StatelessWidget {
  final int index;
  final int order;
  String? food;
  int? count;
  int? protein;
  int? carbohydrate;
  int? calorie;
  int? fat;
  bool isEditMode;

  RegisterMealDialog({
    super.key,
    this.food,
    this.count,
    this.protein,
    this.carbohydrate,
    this.fat,
    this.calorie,
    this.isEditMode = false,
    required this.index,
    required this.order,
  });

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: double.infinity,
        height: 180 * getScaleFactorFromWidth(context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        inputHelper(
                          context,
                          hintText: "개수",
                          initialValue: "${count ?? 0}",
                          width: 60 * getScaleFactorFromWidth(context),
                          height: 30 * getScaleFactorFromWidth(context),
                          inputType: TextInputType.number,
                          maxLength: 2,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "1자리 이상 입력 해주세요";
                            } else if (!match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                          onSaved: (value) => count = int.parse(value!),
                        ),
                        Text(
                          "음식 개수",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.2),
                            fontSize: 10 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        inputHelper(
                          context,
                          hintText: "음식",
                          initialValue: food,
                          width: 70 * getScaleFactorFromWidth(context),
                          height: 30 * getScaleFactorFromWidth(context),
                          maxLength: 6,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "1자리 이상 입력 해주세요";
                            }
                            return null;
                          },
                          onSaved: (value) => food = value,
                        ),
                        Text(
                          "음식 이름",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.2),
                            fontSize: 10 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        inputHelper(
                          context,
                          hintText: "탄수화물",
                          initialValue: "${carbohydrate ?? 0}",
                          width: 60 * getScaleFactorFromWidth(context),
                          height: 30 * getScaleFactorFromWidth(context),
                          inputType: TextInputType.number,
                          maxLength: 3,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "1자리 이상 입력 해주세요";
                            } else if (!match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                          onSaved: (value) => carbohydrate = int.parse(value!),
                        ),
                        Text(
                          "탄수화물",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.2),
                            fontSize: 10 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // 정보 1 행
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        inputHelper(
                          context,
                          hintText: "단백질",
                          initialValue: "${protein ?? 0}",
                          width: 60 * getScaleFactorFromWidth(context),
                          height: 30 * getScaleFactorFromWidth(context),
                          inputType: TextInputType.number,
                          maxLength: 3,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "1자리 이상 입력 해주세요";
                            } else if (!match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                          onSaved: (value) => protein = int.parse(value!),
                        ),
                        Text(
                          "단백질",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.2),
                            fontSize: 10 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        inputHelper(
                          context,
                          hintText: "지방",
                          initialValue: "${fat ?? 0}",
                          width: 60 * getScaleFactorFromWidth(context),
                          height: 30 * getScaleFactorFromWidth(context),
                          inputType: TextInputType.number,
                          maxLength: 3,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "1자리 이상 입력 해주세요";
                            } else if (!match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                          onSaved: (value) => fat = int.parse(value!),
                        ),
                        Text(
                          "지방",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.2),
                            fontSize: 10 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        inputHelper(
                          context,
                          hintText: "칼로리",
                          initialValue: "${calorie ?? 0}",
                          width: 60 * getScaleFactorFromWidth(context),
                          height: 30 * getScaleFactorFromWidth(context),
                          inputType: TextInputType.number,
                          maxLength: 4,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "1자리 이상 입력 해주세요";
                            } else if (!match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                          onSaved: (value) => calorie = int.parse(value!),
                        ),
                        Text(
                          "칼로리",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.2),
                            fontSize: 10 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // 정보 2 행
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButtonMedium(
                    text: "수정",
                    margin: const EdgeInsets.all(5),
                    onPressEvent: () {
                      final form = formkey.currentState;
                      final validate = form!.validate();

                      if (validate) {
                        form.save();
                        final provider = context.read<MealProvider>();
                        provider.editPresetInfo({
                          'food': food,
                          'count': count,
                          'carbohydrate': carbohydrate,
                          'protein': protein,
                          'fat': fat,
                          'calorie': calorie,
                          'index': index,
                          'order': order,
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                  RoundedButtonMedium(
                    text: "삭제",
                    margin: const EdgeInsets.all(5),
                    onPressEvent: () {
                      final provider = context.read<MealProvider>();
                      provider.removePresetInfo(index, order);
                      Navigator.pop(context);
                    },
                  ),
                  RoundedButtonMedium(
                    text: "취소",
                    margin: const EdgeInsets.all(5),
                    onPressEvent: () => Navigator.pop(context),
                  ),
                ],
              ),
              // 컨펌 버튼
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputHelper(
  BuildContext context, {
  int? maxLength,
  String? hintText,
  TextEditingController? controller,
  TextInputType? inputType,
  String? Function(String?)? validator,
  Function(String?)? onSaved,
  double? width,
  double? height,
  String? initialValue,
}) {
  return SizedBox(
    height: height,
    width: (width ?? 80) * getScaleFactorFromWidth(context),
    child: Center(
      child: TextFormField(
        initialValue: initialValue,
        validator: validator,
        keyboardType: inputType,
        controller: controller,
        onSaved: onSaved,
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.center,
        maxLength: maxLength ?? 10,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 10 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.background,
          counterText: "",
          counterStyle: const TextStyle(height: double.minPositive),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.orange,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFFD9DDEB),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
            fontSize: 10 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w600,
          ),
          hintText: hintText ?? "",
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          errorStyle: TextStyle(
            color: Theme.of(context).colorScheme.error.withOpacity(.8),
            fontSize: 6 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
