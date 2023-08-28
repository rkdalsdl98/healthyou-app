import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/traning_provider.dart';
import 'package:healthyou_app/system/message_system.dart';
import 'package:healthyou_app/widget/global/rounded_icon_button.medium.dart';
import 'package:healthyou_app/widget/home/tranning/preset_dialog_items.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../global/rounded_icon_button_small.dart';

class PresetDialog extends StatefulWidget {
  String? name;
  List<dynamic>? items;
  String? daily;
  bool isEdit;

  PresetDialog({
    super.key,
    this.items,
    this.name,
    this.daily,
    this.isEdit = false,
  });

  @override
  State<PresetDialog> createState() => _PresetDialogState();
}

class _PresetDialogState extends State<PresetDialog> {
  final GlobalKey<FormState> weightTraningKey = GlobalKey<FormState>();
  final GlobalKey<FormState> cardioKey = GlobalKey<FormState>();

  String temp = "무산소";
  late List<dynamic> items;

  String? presetName;

  @override
  void initState() {
    super.initState();
    items = widget.items != null ? [...widget.items!] : [];
    presetName = widget.name ?? "";
  }

  void setCurrPresetName(String name) => presetName = name;
  void onChangeRow(String category) {
    setState(() {
      temp = category;
    });
  }

  void confirmPreset(BuildContext context) {
    if (presetName == null || presetName == "") {
      MessageSystem.initSnackBarMessage(
        context,
        MessageIconTypes.NULL,
        message: "프리셋 이름을 입력해주세요.",
      );
      return;
    }

    final provider = context.read<TraningProvider>();
    if (!widget.isEdit) {
      final findItem = provider.isValidPresetByName(presetName ?? "비어있음");
      if (findItem) {
        MessageSystem.initSnackBarMessage(
          context,
          MessageIconTypes.NULL,
          message: "이미 사용중인 이름 입니다",
        );
        return;
      }
    }
    provider.addPreset(presetName ?? "비어있음", items, daily: widget.daily);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.maxFinite,
        height: 200 * getScaleFactorFromHeight(context),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40 * getScaleFactorFromHeight(context),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    inputHelper(
                      context,
                      setCurrValue: setCurrPresetName,
                      initialValue: widget.name,
                      readonly: widget.name != null,
                    ),
                    const Spacer(),
                    RoundedIconButtonMedium(
                      icon: Icon(
                        Icons.check,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.5),
                        size: 12 * getScaleFactorFromWidth(context),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      onPressEvent: () => confirmPreset(context),
                    ),
                    RoundedIconButtonMedium(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.5),
                        size: 12 * getScaleFactorFromWidth(context),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      onPressEvent: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              PresetDialogItems(
                currCategory: temp,
                onChangeRow: onChangeRow,
                weightTraningKey: weightTraningKey,
                cardioKey: cardioKey,
                currItems: items,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputHelper(
  BuildContext context, {
  Function(String)? setCurrValue,
  int? maxLength,
  String? initialValue,
  bool? readonly,
}) {
  return SizedBox(
    width: 80 * getScaleFactorFromWidth(context),
    child: TextFormField(
      initialValue: initialValue,
      onChanged: setCurrValue,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      maxLength: maxLength ?? 10,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 10 * getScaleFactorFromWidth(context),
        fontFamily: 'SpoqaHanSans',
        fontWeight: FontWeight.w600,
      ),
      readOnly: readonly ?? false,
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
          fontSize: 10 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
        hintText: "프리셋 이름",
      ),
    ),
  );
}
