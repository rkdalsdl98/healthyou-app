import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../../provider/timer_provider.dart';
import '../../../system/message_system.dart';
import '../../../system/validate_system.dart';
import '../../../types/validate_types.dart';
import '../rounded_button_medium.dart';

class EditTimerPresetDialog extends StatelessWidget {
  int? minute;
  int? seconds;
  String? name;
  bool showApplyButton;
  Function(int, int)? onPressApply;

  EditTimerPresetDialog({
    super.key,
    this.minute,
    this.seconds,
    this.name,
    this.showApplyButton = false,
    this.onPressApply,
  });

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void savePreset(BuildContext context) {
    final form = formkey.currentState;
    final validate = form!.validate();

    if (validate) {
      form.save();
      final provider = context.read<TimerProvider>();

      try {
        provider.addPreset(
          name ?? "비어있음",
          minute ?? 0,
          seconds ?? 0,
        );
      } catch (e) {
        if (e.toString().contains("RangeOver")) {
          MessageSystem.initSnackBarMessage(
            context,
            MessageIconTypes.NULL,
            message: "더 이상 저장 할 수 없습니다",
          );
        }
      }

      Navigator.pop(context);
    }
  }

  void applyPreset(BuildContext context) {
    onPressApply!(minute ?? 0, seconds ?? 0);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 120),
      child: Container(
        height: 200 * getScaleFactorFromWidth(context),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50 * getScaleFactorFromWidth(context),
                    child: inputHelper(
                      context,
                      width: 100,
                      hintText: "이름",
                      initialValue: name,
                      maxLength: 10,
                      onSaved: (value) => name = value!,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "1자리 이상 입력 해주세요";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50 * getScaleFactorFromWidth(context),
                    child: inputHelper(
                      context,
                      width: 100,
                      hintText: "분",
                      maxLength: 2,
                      initialValue: minute == null ? "" : minute.toString(),
                      inputType: TextInputType.number,
                      onSaved: (value) => minute = int.parse(value!),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "1자리 이상 입력 해주세요";
                        } else if (!match(value, ValidateType.number)) {
                          return "숫자가 아닌값은 입력할 수 없습니다";
                        }

                        int minute = int.parse(value);
                        if (minute > 59) {
                          return "59분 까지 입력이 가능합니다";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50 * getScaleFactorFromWidth(context),
                    child: inputHelper(
                      context,
                      width: 100,
                      hintText: "초",
                      maxLength: 2,
                      initialValue: seconds == null ? "" : seconds.toString(),
                      inputType: TextInputType.number,
                      onSaved: (value) => seconds = int.parse(value!),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "1자리 이상 입력 해주세요";
                        } else if (!match(value, ValidateType.number)) {
                          return "숫자가 아닌값은 입력할 수 없습니다";
                        }

                        int seconds = int.parse(value);
                        if (seconds > 59) {
                          return "59초 까지 입력이 가능합니다";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButtonMedium(
                  text: "저장",
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  onPressEvent: () => savePreset(context),
                ),
                if (showApplyButton)
                  RoundedButtonMedium(
                    text: "적용",
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    onPressEvent: () => applyPreset(context),
                  ),
                RoundedButtonMedium(
                  text: "닫기",
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  onPressEvent: () => Navigator.pop(context),
                ),
              ],
            ),
            const Spacer(),
          ],
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
  double? width,
  String? initialValue,
  Function(String?)? onSaved,
}) {
  return SizedBox(
    width: (width ?? 80) * getScaleFactorFromWidth(context),
    child: TextFormField(
      validator: validator,
      keyboardType: inputType,
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      maxLength: maxLength ?? 10,
      initialValue: initialValue,
      onSaved: onSaved,
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
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
          fontSize: 12 * getScaleFactorFromWidth(context),
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
  );
}
