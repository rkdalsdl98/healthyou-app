import 'package:flutter/material.dart';
import 'package:healthyou_app/widget/global/rounded_button_medium.dart';

import '../../../design/dimensions.dart';

class AddMemoDialog extends StatelessWidget {
  final String title;
  Function(String)? onSaveData;

  AddMemoDialog({
    super.key,
    required this.title,
    this.onSaveData,
  });

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 105),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.maxFinite,
        height: 180 * getScaleFactorFromHeight(context),
        padding: const EdgeInsets.all(10),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: inputHelper(
                context,
                "description",
                width: double.maxFinite,
                hintText: "메모는 최대 20자 까지 입력 가능합니다",
                maxLength: 20,
                onSaveData: (value) => text = value!,
                validator: (value) {
                  if (value == null || value.isEmpty || value == "") {
                    return "1글자 이상 입력해주세요";
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButtonMedium(
                  text: "저장",
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  onPressEvent: () {
                    final form = formKey.currentState;
                    final validate = form!.validate();

                    if (validate && onSaveData != null) {
                      form.save();
                      onSaveData!(text);
                      Navigator.pop(context);
                    }
                  },
                ),
                RoundedButtonMedium(
                  text: "취소",
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  onPressEvent: () => Navigator.pop(context),
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
  BuildContext context,
  String key, {
  int? maxLength,
  TextInputType? inputType,
  String? hintText,
  double? width,
  Function(String?)? onSaveData,
  String? Function(String?)? validator,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    width: (width ?? 45) * getScaleFactorFromWidth(context),
    child: TextFormField(
      onSaved: (value) {
        if (onSaveData != null) {
          onSaveData(value);
        }
      },
      validator: validator,
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.center,
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
      ),
    ),
  );
}
