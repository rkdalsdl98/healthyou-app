import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/notify_provider.dart';
import 'package:healthyou_app/widget/global/rounded_button_medium.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../../system/validate_system.dart';
import '../../../types/validate_types.dart';

class EditNotifyTimeDialog extends StatelessWidget {
  final String identifier;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  EditNotifyTimeDialog({
    super.key,
    required this.identifier,
  });

  @override
  Widget build(BuildContext context) {
    int currHour = 0;
    int currMinute = 0;

    void confirm() {
      final form = formkey.currentState;
      final validate = form!.validate();

      if (validate) {
        form.save();
        final provider = context.read<NotifyProvider>();
        provider.editNotify(identifier, {
          "hour": currHour,
          "minute": currMinute,
        });
        Navigator.pop(context);
      }
    }

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        width: double.maxFinite,
        height: 120 * getScaleFactorFromWidth(context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "알림시간 수정",
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.6),
                fontSize: 12 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Form(
                key: formkey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    inputHelper(
                      context,
                      hintText: "시간",
                      inputType: TextInputType.number,
                      width: 120,
                      height: 60,
                      maxLength: 2,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "1자리 이상 입력 해주세요";
                        } else if (!match(value, ValidateType.number)) {
                          return "숫자가 아닌값은 입력할 수 없습니다";
                        }

                        final toIntValue = int.parse(value);
                        if (toIntValue > 23) {
                          return "23시까지 입력이 가능합니다";
                        }
                        return null;
                      },
                      onSaved: (value) => currHour = int.parse(value!),
                    ),
                    inputHelper(
                      context,
                      hintText: "분",
                      inputType: TextInputType.number,
                      width: 120,
                      height: 60,
                      maxLength: 2,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "1자리 이상 입력 해주세요";
                        } else if (!match(value, ValidateType.number)) {
                          return "숫자가 아닌값은 입력할 수 없습니다";
                        }

                        final toIntValue = int.parse(value);
                        if (toIntValue > 59) {
                          return "59분까지 입력이 가능합니다";
                        }
                        return null;
                      },
                      onSaved: (value) => currMinute = int.parse(value!),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButtonMedium(
                  text: "저장",
                  onPressEvent: confirm,
                  margin: const EdgeInsets.all(5),
                ),
                RoundedButtonMedium(
                  text: "닫기",
                  onPressEvent: () => Navigator.pop(context),
                  margin: const EdgeInsets.all(5),
                ),
              ],
            ),
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
            ),
          ),
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
            fontSize: 14 * getScaleFactorFromWidth(context),
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
            fontSize: 8 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
