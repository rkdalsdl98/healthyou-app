import 'package:flutter/material.dart';
import 'package:healthyou_app/widget/global/rounded_icon_button.medium.dart';
import 'package:healthyou_app/widget/home/tranning/preset_dialog_item.dart';
import 'package:healthyou_app/widget/home/tranning/preset_row.dart';

import '../../../design/dimensions.dart';
import '../../../system/message_system.dart';
import '../../global/rounded_icon_button_small.dart';

class PresetDialogItems extends StatefulWidget {
  final String currCategory;
  final Function(String) onChangeRow;
  final List<dynamic> currItems;
  final GlobalKey<FormState> weightTraningKey;
  final GlobalKey<FormState> cardioKey;

  const PresetDialogItems({
    super.key,
    required this.currCategory,
    required this.onChangeRow,
    required this.weightTraningKey,
    required this.cardioKey,
    required this.currItems,
  });

  @override
  State<PresetDialogItems> createState() => _PresetDialogItemsState();
}

class _PresetDialogItemsState extends State<PresetDialogItems> {
  Map<String, dynamic> result = {};

  void saveData(String key, dynamic data) {
    result.update(
      key,
      (_) => data,
      ifAbsent: () => data,
    );
  }

  void onDeleteItem(int order) {
    widget.currItems.removeWhere((e) => e['order'] == order);
    setState(() {});
  }

  void onPressAddButton() {
    FormState? form;

    if (widget.currCategory == "무산소") {
      form = widget.weightTraningKey.currentState;
    } else {
      form = widget.cardioKey.currentState;
    }
    form!.save();
    final validate = result.keys.every((key) => result[key] != "");

    if (!validate) {
      result = {};
      MessageSystem.initSnackBarMessage(
        context,
        MessageIconTypes.NULL,
        message: "빈칸을 모두 채워 주세요.",
      );
      return;
    }

    result.addAll(
        {"identifier": widget.currCategory, "order": widget.currItems.length});
    widget.currItems.add(result);
    result = {};
    form.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var item in widget.currItems)
          item['identifier'] == "무산소"
              ? PresetDialogItem.dialogItemByWeightTraning(
                  onDeleteItem,
                  context,
                  data: item,
                )
              : PresetDialogItem.dialogItemByCardio(
                  onDeleteItem,
                  context,
                  data: item,
                ),
        SizedBox(
          width: double.maxFinite,
          height: 40 * getScaleFactorFromHeight(context),
          child: PresetRow(
            currCategory: widget.currCategory,
            onSaveData: saveData,
            onChangeRow: widget.onChangeRow,
            weightTraningKey: widget.weightTraningKey,
            cardioKey: widget.cardioKey,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: RoundedIconButtonMedium(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
              size: 12 * getScaleFactorFromWidth(context),
            ),
            onPressEvent: onPressAddButton,
          ),
        ),
      ],
    );
  }
}
