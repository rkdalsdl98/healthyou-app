import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthyou_app/model/timer/timer_preset_model.dart';
import 'package:healthyou_app/provider/timer_provider.dart';
import 'package:healthyou_app/repository/timer_repository.dart';
import 'package:healthyou_app/system/validate_system.dart';
import 'package:healthyou_app/types/validate_types.dart';
import 'package:healthyou_app/widget/global/rounded_button_medium.dart';
import 'package:healthyou_app/widget/global/timer/edit_timer_preset_dialog.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';

class CustomTimer extends StatefulWidget {
  const CustomTimer({
    super.key,
  });

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  int currMinute = 0;
  int currSeconds = 0;

  Timer? timer;
  bool isStartedTimer = false;

  void setMinute(int minute) => setState(() {
        currMinute = minute;
      });
  void setSeconds(int seconds) => setState(() {
        currSeconds = seconds;
      });

  void startTimer() {
    final provider = context.read<TimerProvider>();

    isStartedTimer = true;
    timer = Timer.periodic(const Duration(seconds: 1), (currTimer) {
      if (currSeconds < 1) {
        if (currMinute < 1) {
          currTimer.cancel();
          isStartedTimer = false;
          provider.changeTimerState(TimerState.idle);
          return;
        }
        --currMinute;
        currSeconds = 59;
      } else {
        --currSeconds;
      }
      setState(() {});
    });
    provider.changeTimerState(TimerState.start);
  }

  void cancelTimer(bool isPause) {
    final provider = context.read<TimerProvider>();

    if (!isPause) {
      currMinute = 0;
      currSeconds = 0;
      provider.changeTimerState(TimerState.idle);
    } else {
      provider.changeTimerState(TimerState.pause);
    }
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }

    isStartedTimer = false;
    setState(() {});
  }

  void editMinute(BuildContext context) {
    if (isStartedTimer) return;

    TextEditingController controller = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        insetPadding: EdgeInsets.all(120 * getScaleFactorFromWidth(context)),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Container(
          height: 100 * getScaleFactorFromWidth(context),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(dialogContext).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              SizedBox(
                height: 50 * getScaleFactorFromWidth(context),
                child: Form(
                  key: formkey,
                  child: inputHelper(
                    context,
                    width: 120,
                    hintText: "분",
                    maxLength: 2,
                    inputType: TextInputType.number,
                    controller: controller,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "1자리 이상 입력 해주세요";
                      } else if (!match(value, ValidateType.number)) {
                        return "숫자가 아닌값은 입력할 수 없습니다";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const Spacer(),
              RoundedButtonMedium(
                text: "저장",
                onPressEvent: () {
                  final form = formkey.currentState;
                  final validate = form!.validate();

                  if (validate) {
                    setMinute(int.parse(controller.text));
                    Navigator.pop(context);
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void editSeconds(BuildContext context) {
    if (isStartedTimer) return;

    TextEditingController controller = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        insetPadding: EdgeInsets.all(120 * getScaleFactorFromWidth(context)),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Container(
          height: 100 * getScaleFactorFromWidth(context),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(dialogContext).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              SizedBox(
                height: 50 * getScaleFactorFromWidth(context),
                child: Form(
                  key: formkey,
                  child: inputHelper(
                    context,
                    width: 120,
                    hintText: "초",
                    maxLength: 2,
                    inputType: TextInputType.number,
                    controller: controller,
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
              ),
              const Spacer(),
              RoundedButtonMedium(
                text: "저장",
                onPressEvent: () {
                  final form = formkey.currentState;
                  final validate = form!.validate();

                  if (validate) {
                    setSeconds(int.parse(controller.text));
                    Navigator.pop(context);
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void onPressAddButton() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ChangeNotifierProvider<TimerProvider>.value(
        value: context.read<TimerProvider>(),
        child: EditTimerPresetDialog(),
      ),
    );
  }

  void editPreset(TimerPresetModel preset) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ChangeNotifierProvider<TimerProvider>.value(
        value: context.read<TimerProvider>(),
        child: EditTimerPresetDialog(
          minute: preset.minute ?? 0,
          seconds: preset.seconds ?? 0,
          name: preset.name ?? "비어있음",
          showApplyButton: true,
          onPressApply: setApplyPreset,
        ),
      ),
    );
  }

  void removePreset(TimerPresetModel preset) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ChangeNotifierProvider<TimerProvider>.value(
        value: context.read<TimerProvider>(),
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 100),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 120 * getScaleFactorFromWidth(context),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${preset.name} 삭제",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 12 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "해당 프리셋을 정말\n삭제 하시겠습니까?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 10 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButtonMedium(
                      text: "확인",
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      onPressEvent: () {
                        final provider = context.read<TimerProvider>();
                        provider.removePreset(preset.name ?? "비어있음");
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
      ),
    );
  }

  void setApplyPreset(int minute, int seconds) {
    setState(() {
      currMinute = minute;
      currSeconds = seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300 * getScaleFactorFromWidth(context),
      height: 240 * getScaleFactorFromHeight(context),
      child: Column(
        children: [
          addPresetButtonHelper(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(flex: 2),
              InkWell(
                onTap: () => editMinute(context),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 14 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      height: 1.5,
                    ),
                    text: "분\n",
                    children: [
                      TextSpan(
                        text: "$currMinute".padLeft(2, "0"),
                        style: TextStyle(
                          fontSize: 32 * getScaleFactorFromWidth(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                ":",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 32 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => editSeconds(context),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 14 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      height: 1.5,
                    ),
                    text: "초\n",
                    children: [
                      TextSpan(
                        text: "$currSeconds".padLeft(2, "0"),
                        style: TextStyle(
                          fontSize: 32 * getScaleFactorFromWidth(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
          Consumer<TimerProvider>(builder: (_, provider, __) {
            final presets = provider.presets;

            final TimerState state = provider.state!;
            Widget? timerWidget;
            if (state == TimerState.pause) {
              timerWidget = pauseButtonHelper(context, startTimer, cancelTimer);
            } else if (state == TimerState.start) {
              timerWidget = startButtonHelper(context, cancelTimer);
            } else {
              timerWidget = idleButtonHelper(startTimer);
            }

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var preset in presets)
                      restTimePresetHelper(
                        context,
                        preset,
                        editPreset,
                        removePreset,
                      ),
                  ],
                ),
                timerWidget,
              ],
            );
          })
        ],
      ),
    );
  }

  Widget addPresetButtonHelper(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () => onPressAddButton(),
          child: Icon(
            Icons.add,
            size: 16 * getScaleFactorFromWidth(context),
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}

Widget restTimePresetHelper(
  BuildContext context,
  TimerPresetModel preset,
  Function(TimerPresetModel) onEditPreset,
  Function(TimerPresetModel) onRemovePreset,
) {
  return GestureDetector(
    onLongPress: () => onRemovePreset(preset),
    onTap: () => onEditPreset(preset),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      height: 60 * getScaleFactorFromHeight(context),
      child: Row(
        children: [
          Container(
            width: 60 * getScaleFactorFromHeight(context),
            height: 60 * getScaleFactorFromHeight(context),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(180),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.25),
                  offset: const Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 6 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    height: 1.5,
                  ),
                  text: "${preset.name}\n",
                  children: [
                    TextSpan(
                        text:
                            "${"${preset.minute}".padLeft(2, "0")}:${"${preset.seconds}".padLeft(2, "0")}"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget inputHelper(
  BuildContext context, {
  int? maxLength,
  String? hintText,
  TextEditingController? controller,
  TextInputType? inputType,
  String? Function(String?)? validator,
  double? width,
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

Widget pauseButtonHelper(
  BuildContext context,
  Function() onStartEvent,
  Function(bool) onCancelEvent,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RoundedButtonMedium(
        text: "취소",
        margin: const EdgeInsets.symmetric(horizontal: 10),
        onPressEvent: () => onCancelEvent(false),
      ),
      RoundedButtonMedium(
        text: "계속",
        margin: const EdgeInsets.symmetric(horizontal: 10),
        buttonColor: Theme.of(context).colorScheme.errorContainer,
        textColor:
            Theme.of(context).colorScheme.onErrorContainer.withOpacity(.5),
        onPressEvent: onStartEvent,
        borderWidth: 0,
      ),
    ],
  );
}

Widget startButtonHelper(
  BuildContext context,
  Function(bool) onCancelEvent,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RoundedButtonMedium(
        text: "취소",
        margin: const EdgeInsets.symmetric(horizontal: 10),
        onPressEvent: () => onCancelEvent(false),
      ),
      RoundedButtonMedium(
        text: "일시정지",
        margin: const EdgeInsets.symmetric(horizontal: 10),
        buttonColor: Theme.of(context).colorScheme.error,
        textColor: Theme.of(context).colorScheme.onError,
        onPressEvent: () => onCancelEvent(true),
        borderWidth: 0,
      ),
    ],
  );
}

Widget idleButtonHelper(Function() onStartEvent) {
  return Align(
    alignment: Alignment.center,
    child: RoundedButtonMedium(
      text: "시작",
      margin: const EdgeInsets.symmetric(horizontal: 10),
      onPressEvent: onStartEvent,
    ),
  );
}
