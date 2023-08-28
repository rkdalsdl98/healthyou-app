import 'package:flutter/material.dart';
import 'package:healthyou_app/model/traning/traning_preset_model.dart';
import 'package:healthyou_app/widget/global/rounded_icon_button.medium.dart';
import 'package:healthyou_app/widget/home/tranning/preset_item.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../../provider/traning_provider.dart';
import '../../global/rounded_button_medium.dart';
import '../../global/rounded_icon_button_small.dart';

class Preset extends StatefulWidget {
  final Function(
    bool isEdit, {
    List<dynamic>? items,
    String? name,
    String? daily,
  }) onShowEditDialog;
  final TraningPreset preset;

  const Preset({
    super.key,
    required this.preset,
    required this.onShowEditDialog,
  });

  @override
  State<Preset> createState() => _PresetState();
}

class _PresetState extends State<Preset> {
  int currPage = 0;
  PageController pageController = PageController();

  void removePreset(BuildContext context, String name) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 120),
        child: Container(
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.hardEdge,
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
          height: 140 * getScaleFactorFromWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "해당 프리셋을 정말로 삭제 하시겠습니까?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 10 * getScaleFactorFromWidth(context),
                        fontFamily: 'SpoqaHanSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "연결된 운동결과도 함께 초기화 됩니다.",
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.5),
                      fontSize: 8 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButtonMedium(
                    text: "삭제",
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    onPressEvent: () {
                      final provider = context.read<TraningProvider>();
                      provider.removePreset(widget.preset.index!);
                      if (widget.preset.daily != null) {
                        final currSchedule =
                            provider.getSchedule(widget.preset.daily!);
                        if (currSchedule != null &&
                            currSchedule.state != "idle") {
                          provider.decreaseAchievementDays();
                        }
                        provider.removeSchedule(widget.preset.daily!);
                      }

                      Navigator.pop(context);
                    },
                  ),
                  RoundedButtonMedium(
                    text: "취소",
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    onPressEvent: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 300 * getScaleFactorFromWidth(context),
      height: 200 * getScaleFactorFromHeight(context),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.25),
            offset: const Offset(0, 4),
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 30 * getScaleFactorFromHeight(context),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.preset.name ?? "비어있음",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 8 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                RoundedIconButtonMedium(
                  icon: Icon(
                    Icons.edit,
                    size: 8 * getScaleFactorFromWidth(context),
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.5),
                  ),
                  onPressEvent: () => widget.onShowEditDialog(
                    true,
                    items: widget.preset.presetItems,
                    name: widget.preset.name,
                    daily: widget.preset.daily,
                  ),
                ),
                RoundedIconButtonMedium(
                  icon: Icon(
                    Icons.close,
                    size: 12 * getScaleFactorFromWidth(context),
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.5),
                  ),
                  onPressEvent: () {
                    removePreset(context, widget.preset.name ?? "비어있음");
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var item in widget.preset.presetItems!)
                    PresetItem(item: item)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
