import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/user_provider.dart';
import 'package:healthyou_app/widget/global/rounded_button_medium.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../../system/validate_system.dart';
import '../../../types/validate_types.dart';

class EditInfoDialog extends StatelessWidget {
  EditInfoDialog({
    super.key,
  });

  Map<String, dynamic> result = {};
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void onSaveData(String key, String? value) {
    result.update(
      key,
      (_) => value,
      ifAbsent: () => value,
    );
  }

  void confirm(BuildContext context) {
    final form = formKey.currentState;
    final validate = form!.validate();

    if (validate) {
      form.save();
      result.updateAll((_, value) {
        if (value == "" || value == null) {
          return null;
        }
        return int.parse(value);
      });
      final provider = context.read<UserProvider>();
      provider.updateInfo(result);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 120),
      child: Container(
        padding: const EdgeInsets.all(10),
        clipBehavior: Clip.hardEdge,
        width: double.maxFinite,
        height: 300 * getScaleFactorFromHeight(context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Theme.of(context).colorScheme.shadow.withOpacity(.25),
            )
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "정보 수정",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Consumer<UserProvider>(builder: (_, provider, __) {
              final info = provider.info;
              return Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        inputHelper(
                          context,
                          "weight",
                          width: double.maxFinite,
                          hintText: "몸무게를 입력해주세요",
                          inputType: TextInputType.number,
                          onSaveData: onSaveData,
                          initialValue: "${info!.weight ?? ""}",
                          maxLength: 3,
                          suffixText: "몸무게",
                          validator: (value) {
                            if (value != null &&
                                value != "" &&
                                !match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                        ),
                        inputHelper(
                          context,
                          "height",
                          width: double.maxFinite,
                          hintText: "키를 입력해주세요",
                          inputType: TextInputType.number,
                          onSaveData: onSaveData,
                          initialValue: "${info.height ?? ""}",
                          maxLength: 3,
                          suffixText: "키",
                          validator: (value) {
                            if (value != null &&
                                value != "" &&
                                !match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                        ),
                        inputHelper(
                          context,
                          "age",
                          width: double.maxFinite,
                          hintText: "나이를 입력해주세요",
                          inputType: TextInputType.number,
                          onSaveData: onSaveData,
                          initialValue: "${info.age ?? ""}",
                          maxLength: 3,
                          suffixText: "나이",
                          validator: (value) {
                            if (value != null &&
                                value != "" &&
                                !match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                        ),
                        inputHelper(
                          context,
                          "skeletalMuscle",
                          width: double.maxFinite,
                          hintText: "골격근량을 입력해주세요",
                          inputType: TextInputType.number,
                          onSaveData: onSaveData,
                          initialValue: "${info.skeletalMuscle ?? ""}",
                          maxLength: 3,
                          suffixText: "골격근량",
                          validator: (value) {
                            if (value != null &&
                                value != "" &&
                                !match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                        ),
                        inputHelper(
                          context,
                          "bodyFat",
                          width: double.maxFinite,
                          hintText: "체지방량을 입력해주세요",
                          inputType: TextInputType.number,
                          onSaveData: onSaveData,
                          initialValue: "${info.bodyFat ?? ""}",
                          maxLength: 3,
                          suffixText: "체지방량",
                          validator: (value) {
                            if (value != null &&
                                value != "" &&
                                !match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                        ),
                        inputHelper(
                          context,
                          "bodyFatPercent",
                          width: double.maxFinite,
                          hintText: "체지방률을 입력해주세요",
                          maxLength: 2,
                          suffixText: "체지방률",
                          inputType: TextInputType.number,
                          onSaveData: onSaveData,
                          initialValue: "${info.bodyFatPercent ?? ""}",
                          validator: (value) {
                            if (value != null &&
                                value != "" &&
                                !match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                        ),
                        inputHelper(
                          context,
                          "bmi",
                          width: double.maxFinite,
                          hintText: "BMI를 입력해주세요",
                          inputType: TextInputType.number,
                          onSaveData: onSaveData,
                          maxLength: 2,
                          suffixText: "BMI",
                          initialValue: "${info.bmi ?? ""}",
                          validator: (value) {
                            if (value != null &&
                                value != "" &&
                                !match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                        ),
                        inputHelper(
                          context,
                          "basalMetabolicRate",
                          width: double.maxFinite,
                          hintText: "기초 대사량을 입력해주세요",
                          inputType: TextInputType.number,
                          initialValue: "${info.basalMetabolicRate ?? ""}",
                          onSaveData: onSaveData,
                          maxLength: 5,
                          suffixText: "기초 대사량",
                          validator: (value) {
                            if (value != null &&
                                value != "" &&
                                !match(value, ValidateType.number)) {
                              return "숫자가 아닌값은 입력할 수 없습니다";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            RoundedButtonMedium(
              text: "저장",
              onPressEvent: () => confirm(context),
            ),
          ],
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
  Function(String, String?)? onSaveData,
  String? Function(String?)? validator,
  String? initialValue,
  String? suffixText,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    width: (width ?? 45) * getScaleFactorFromWidth(context),
    height: 45 * getScaleFactorFromWidth(context),
    child: TextFormField(
      onSaved: (value) {
        if (onSaveData != null) {
          onSaveData(key, value);
        }
      },
      initialValue: initialValue,
      validator: validator,
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.center,
      maxLength: maxLength ?? 10,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 8 * getScaleFactorFromWidth(context),
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
            )),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFFE94251),
          ),
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
          fontSize: 8 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
        hintText: hintText,
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 6 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
        suffixText: suffixText,
      ),
    ),
  );
}
