import 'package:flutter/material.dart';
import 'package:healthyou_app/widget/global/rounded_icon_button.medium.dart';
import 'package:healthyou_app/widget/global/rounded_icon_button_small.dart';

import '../../../design/dimensions.dart';

class PresetDialogItem {
  static Widget inputDialogItemByWeightTraning(
    BuildContext context,
    GlobalKey<FormState> key,
    Function(String, dynamic) onSaveData,
  ) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: key,
      child: Row(
        children: [
          inputHelper(
            context,
            "machine",
            hintText: "운동or기구",
            width: 65,
            maxLength: 10,
            onSaveData: onSaveData,
          ),
          inputHelper(
            context,
            "weight",
            hintText: "무게",
            maxLength: 3,
            inputType: TextInputType.number,
            onSaveData: onSaveData,
          ),
          inputHelper(
            context,
            "count",
            hintText: "횟수",
            maxLength: 3,
            inputType: TextInputType.number,
            onSaveData: onSaveData,
          ),
          inputHelper(
            context,
            "totalSet",
            hintText: "세트",
            maxLength: 3,
            inputType: TextInputType.number,
            onSaveData: onSaveData,
          ),
          inputHelper(
            context,
            "restTime",
            hintText: "쉬는시간",
            width: 60,
            maxLength: 3,
            onSaveData: onSaveData,
            inputType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  static Widget inputDialogItemByCardio(
    BuildContext context,
    GlobalKey<FormState> key,
    Function(String, dynamic) onSaveData,
  ) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: key,
      child: Row(
        children: [
          inputHelper(
            context,
            "machine",
            hintText: "운동or기구",
            width: 65,
            maxLength: 10,
            onSaveData: onSaveData,
          ),
          inputHelper(
            context,
            "distance",
            hintText: "거리",
            maxLength: 3,
            inputType: TextInputType.number,
            onSaveData: onSaveData,
          ),
          inputHelper(
            context,
            "restTime",
            hintText: "쉬는시간",
            width: 60,
            maxLength: 3,
            inputType: TextInputType.number,
            onSaveData: onSaveData,
          ),
        ],
      ),
    );
  }

  static Widget dialogItemByWeightTraning(
    Function(int) onDeleteItem,
    BuildContext context, {
    Map<String, dynamic>? data,
  }) {
    TextStyle style = TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontSize: 8 * getScaleFactorFromWidth(context),
      fontFamily: 'SpoqaHanSans',
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    );
    var seconds = data?['restTime'];
    String restTime = "";
    if (seconds != null) {
      seconds = int.parse(seconds);
      var minute = seconds ~/ 60;
      seconds -= minute * 60;
      restTime =
          "${minute < 1 ? "" : "$minute 분 "}${seconds < 1 ? "" : "$seconds 초"}";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 40 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(
                data?['identifier'] ?? "",
                style: style,
              ),
            ),
          ),
          SizedBox(
            width: 50 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(
                data?['machine'] ?? "",
                style: style,
              ),
            ),
          ),
          SizedBox(
            width: 40 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(
                data?['weight'] != null ? "${data!['weight']} kg" : "0 kg",
                style: style,
              ),
            ),
          ),
          SizedBox(
            width: 40 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(
                data?['count'] != null ? "${data!['count']} 회" : "0 회",
                style: style,
              ),
            ),
          ),
          SizedBox(
            width: 40 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(
                data?['totalSet'] != null ? "${data!['totalSet']} 세트" : "0 세트",
                style: style,
              ),
            ),
          ),
          SizedBox(
            width: 40 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(
                restTime != "" ? restTime : "0 초",
                style: style,
              ),
            ),
          ),
          const Spacer(),
          RoundedIconButtonMedium(
            icon: Icon(
              Icons.close,
              size: 12 * getScaleFactorFromWidth(context),
            ),
            onPressEvent: () => onDeleteItem(data?['order']),
          ),
        ],
      ),
    );
  }

  static Widget dialogItemByCardio(
    Function(int) onDeleteItem,
    BuildContext context, {
    Map<String, dynamic>? data,
  }) {
    TextStyle style = TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontSize: 8 * getScaleFactorFromWidth(context),
      fontFamily: 'SpoqaHanSans',
      fontWeight: FontWeight.w400,
    );
    var seconds = data?['restTime'];
    String restTime = "";
    if (seconds != null) {
      seconds = int.parse(seconds);
      var minute = seconds ~/ 60;
      seconds -= minute * 60;
      restTime =
          "${minute < 1 ? "" : "$minute 분 "}${seconds < 1 ? "" : "$seconds 초"}";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 40 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(data?['identifier'] ?? "", style: style),
            ),
          ),
          SizedBox(
            width: 50 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(data?['machine'] ?? "", style: style),
            ),
          ),
          SizedBox(
            width: 40 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(
                  data?['distance'] != null
                      ? "${data!['distance']} km"
                      : "0 km",
                  style: style),
            ),
          ),
          SizedBox(
            width: 40 * getScaleFactorFromWidth(context),
            child: Center(
              child: Text(
                restTime != "" ? restTime : "0 초",
                style: style,
              ),
            ),
          ),
          const Spacer(),
          RoundedIconButtonMedium(
            icon: Icon(
              Icons.close,
              size: 12 * getScaleFactorFromWidth(context),
            ),
            onPressEvent: () => onDeleteItem(data?['order']),
          ),
        ],
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
  double? height,
  Function(String, dynamic)? onSaveData,
}) {
  return SizedBox(
    width: (width ?? 45) * getScaleFactorFromWidth(context),
    height: height,
    child: TextFormField(
      onSaved: (value) {
        if (onSaveData != null) {
          onSaveData(key, value ?? "");
        }
      },
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
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
          fontSize: 8 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
        hintText: hintText,
      ),
    ),
  );
}
