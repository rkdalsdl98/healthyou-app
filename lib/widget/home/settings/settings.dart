import 'package:flutter/material.dart';
import 'package:healthyou_app/design/dimensions.dart';
import 'package:healthyou_app/provider/notify_provider.dart';
import 'package:healthyou_app/widget/home/settings/setting_item.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Consumer<NotifyProvider>(
        builder: (_, provider, __) {
          final notifies = provider.notifies;
          return Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 30 * getScaleFactorFromWidth(context),
                color: const Color(0xFFD9DDEB),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '알림',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.5),
                        fontSize: 10 * getScaleFactorFromWidth(context),
                        fontFamily: 'SpoqaHanSans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              for (var notify in notifies) SettingItem(notify: notify),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "시간을 눌러 원하는 시간으로 변경 할 수 있습니다.",
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.5),
                      fontSize: 8 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
