import 'package:flutter/material.dart';
import 'package:healthyou_app/widget/home/tranning/preset_dialog_item.dart';

import '../../global/default_drop_down_button.dart';

class PresetRow extends StatelessWidget {
  const PresetRow({
    super.key,
    required this.currCategory,
    required this.onSaveData,
    required this.onChangeRow,
    required this.weightTraningKey,
    required this.cardioKey,
  });

  final String currCategory;
  final Function(String, dynamic) onSaveData;
  final Function(String) onChangeRow;
  final GlobalKey<FormState> weightTraningKey;
  final GlobalKey<FormState> cardioKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: DefaultDropDownButton(
              currValue: currCategory,
              setCurrValue: onChangeRow,
              items: const ["무산소", "유산소"],
            ),
          ),
          if (currCategory == "무산소")
            PresetDialogItem.inputDialogItemByWeightTraning(
              context,
              weightTraningKey,
              onSaveData,
            ),
          if (currCategory == "유산소")
            PresetDialogItem.inputDialogItemByCardio(
              context,
              cardioKey,
              onSaveData,
            )
        ],
      ),
    );
  }
}
