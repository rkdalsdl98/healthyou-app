import 'package:flutter/material.dart';
import 'package:healthyou_app/widget/global/long_text_button.dart';

import '../../design/dimensions.dart';
import '../../system/validate_system.dart';
import '../../types/validate_types.dart';

class SecondWelcomePage extends StatelessWidget {
  final Function(Map<String, dynamic>) onPressEvent;

  SecondWelcomePage({
    super.key,
    required this.onPressEvent,
  });

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, dynamic> result = {};

  void onSaveData(String key, String? value) {
    result.update(
      key,
      (_) => value,
      ifAbsent: () => value,
    );
  }

  void confirm() {
    final form = formKey.currentState;
    final validate = form!.validate();

    if (validate) {
      form.save();
      onPressEvent(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
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
                maxLength: 3,
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
                maxLength: 3,
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
                maxLength: 3,
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
                maxLength: 3,
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
                maxLength: 3,
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
                inputType: TextInputType.number,
                onSaveData: onSaveData,
                maxLength: 2,
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
                maxLength: 2,
                onSaveData: onSaveData,
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
                onSaveData: onSaveData,
                maxLength: 5,
                validator: (value) {
                  if (value != null &&
                      value != "" &&
                      !match(value, ValidateType.number)) {
                    return "숫자가 아닌값은 입력할 수 없습니다";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.5),
                      fontSize: 12 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w600,
                    ),
                    text: "모르는 정보나 입력하기 싫은 부분은 기입하지\n않아도 다음으로 넘어갈 수 있습니다.\n\n",
                    children: const [
                      TextSpan(
                          text:
                              "해당 정보들은 언제든 수정이 가능하며 여러분들이 볼 수 있도록 표기하기 위한 정보들 이며, 다른 용도로는 사용되지 않습니다."),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: LongTextButton(
                  text: "다음",
                  onPressEvent: confirm,
                ),
              ),
            ],
          ),
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
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    width: (width ?? 45) * getScaleFactorFromWidth(context),
    child: TextFormField(
      onSaved: (value) {
        if (onSaveData != null) {
          onSaveData(key, value);
        }
      },
      validator: validator,
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.center,
      maxLength: maxLength ?? 10,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 14 * getScaleFactorFromWidth(context),
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
          fontSize: 14 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
        hintText: hintText,
      ),
    ),
  );
}
