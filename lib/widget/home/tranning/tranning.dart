import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/traning_provider.dart';
import 'package:healthyou_app/widget/global/help_text_dialog.dart';
import 'package:healthyou_app/widget/home/tranning/preset.dart';
import 'package:healthyou_app/widget/home/tranning/preset_dialog.dart';
import 'package:healthyou_app/widget/home/tranning/schedules.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../global/rounded_button_medium.dart';

class Traning extends StatefulWidget {
  const Traning({super.key});

  @override
  State<Traning> createState() => _TraningState();
}

class _TraningState extends State<Traning> {
  void showEditDialog(
    bool isEdit, {
    List<dynamic>? items,
    String? name,
    String? daily,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => ScaffoldMessenger(
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: PresetDialog(
              items: items,
              name: name,
              daily: daily,
              isEdit: isEdit,
            ),
          );
        }),
      ),
    );
  }

  void onPressAddPresetButton(
    BuildContext context,
  ) {
    showEditDialog(false);
  }

  void showHelpDialog() {
    showDialog(
      context: context,
      builder: (_) => const HelpTextDialog(
        texts: [
          "각 날짜에 등록할 수 있는 프리셋은 1개 입니다.",
          "프리셋을 삭제 할 경우, 연결된 정보도 함께 초기화 됩니다.",
          "프리셋 이름은 중복이 불가능 합니다.",
          "지정된 프리셋 이름은 변경이 불가능 합니다.",
          "초기화 버튼으로 스케쥴을 삭제 할 경우,\n연결된 정보도 함께 초기화 됩니다."
        ],
        title: "도움말",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: RoundedButtonMedium(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                text: "도움말",
                onPressEvent: showHelpDialog,
              ),
            ),
            const Schedules(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Consumer<TraningProvider>(builder: (_, provider, __) {
                final presets = provider.presets;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          '나의 운동 프리셋',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 12 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    for (var preset in presets)
                      Preset(
                        preset: preset,
                        onShowEditDialog: showEditDialog,
                      ),
                    SizedBox(height: 10 * getScaleFactorFromHeight(context)),
                  ],
                );
              }),
            ),
            addPresetButtonHelper(context),
          ],
        ),
      ),
    );
  }

  Widget addPresetButtonHelper(BuildContext context) {
    context.read<TraningProvider>();
    return Container(
      width: 50 * getScaleFactorFromWidth(context),
      height: 50 * getScaleFactorFromWidth(context),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.25),
            offset: const Offset(0, 2),
            blurRadius: 4,
          )
        ],
      ),
      child: TextButton(
        onPressed: () => onPressAddPresetButton(context),
        child: Text(
          "+",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 24 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
