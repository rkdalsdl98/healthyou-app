import 'package:flutter/material.dart';
import 'package:healthyou_app/model/notify/notify_model.dart';
import 'package:healthyou_app/provider/notify_provider.dart';
import 'package:healthyou_app/system/unit_system.dart';
import 'package:provider/provider.dart';

import '../../../design/dimensions.dart';
import '../../../system/message_system.dart';
import '../../global/on_off_slider.dart';
import 'edit_notify_time_dialog.dart';

class SettingItem extends StatelessWidget {
  final NotifyModel notify;

  const SettingItem({
    super.key,
    required this.notify,
  });

  void showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext_) => ScaffoldMessenger(
        child: Builder(
          builder: (builderContext) => Scaffold(
            backgroundColor: Colors.transparent,
            body: EditNotifyTimeDialog(identifier: notify.identifier!),
          ),
        ),
      ),
    );
  }

  void onChangeSlider(BuildContext context, bool value) {
    final provider = context.read<NotifyProvider>();
    if (value) {
      try {
        provider.registerMessage(
          notify.id,
          title: notify.title,
          message: notify.message,
          hour: notify.hour,
          minutes: notify.minute,
        );
        MessageSystem.initSnackBarMessage(
          context,
          MessageIconTypes.DONE,
          message: "성공적으로 알림을 등록했습니다.",
        );
      } catch (e) {
        MessageSystem.initSnackBarErrorMessage(
          context,
          message: "알 수 없는 이유로 알림 등록에 실패했습니다.",
          error: e.toString(),
        );
        provider.cancelMessage(notify.id);
      }
    } else {
      provider.cancelMessage(notify.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 60 * getScaleFactorFromWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            notify.widgetTitle!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 12 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              OnOffSlider(
                onChangeValue: onChangeSlider,
                duration: const Duration(milliseconds: 200),
                initialValue: notify.isActive!,
              ),
              Row(
                children: [
                  Text(
                    '매일',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.5),
                      fontSize: 10 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 5 * getScaleFactorFromWidth(context)),
                  Column(
                    children: [
                      timeHelper(
                        context,
                        hour: notify.hour,
                        minute: notify.minute,
                      ),
                      Text(
                        '(1회)',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.5),
                          fontSize: 10 * getScaleFactorFromWidth(context),
                          fontFamily: 'SpoqaHanSans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget timeHelper(
    BuildContext context, {
    int? hour,
    int? minute,
  }) {
    return InkWell(
      onTap: () => showEditDialog(context),
      child: Row(
        children: [
          Text(
            '${"${hour ?? 0}".padLeft(2, "0")} :',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
              fontSize: 10 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            ' ${"${minute ?? 0}".padLeft(2, "0")}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
              fontSize: 10 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
