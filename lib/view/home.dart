import 'package:flutter/material.dart';
import 'package:healthyou_app/design/dimensions.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/provider/traning_provider.dart';
import 'package:healthyou_app/provider/user_provider.dart';
import 'package:healthyou_app/system/message_system.dart';
import 'package:healthyou_app/widget/home/update_dialog.dart';
import 'package:provider/provider.dart';

import '../widget/global/side_bar.dart';
import '../widget/home/calendar/calendar.dart';
import '../widget/home/meal/meal.dart';
import '../widget/home/profile/info.dart';
import '../widget/home/settings/settings.dart';
import '../widget/home/tranning/tranning.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  int selectedMenuIndex = 0;

  void setSelectedMenuIndex(int index) => setState(() {
        selectedMenuIndex = index;
      });

  Future<void> updateMessageDialog(
    Function() onPressEvent,
    String title,
    String text,
  ) async {
    await Future.delayed(const Duration(seconds: 1)).then((_) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => UpdateDialog(
          title: title,
          text: text,
          onPressEvent: onPressEvent,
          setPage: setSelectedMenuIndex,
        ),
      );
    });
  }

  void onCheckUpdate() {
    final provider = context.read<UserProvider>();
    final updated = provider.checkUpdated();
    if (updated == "daily") {
      updateMessageDialog(
        dailyReset,
        "일일 초기화",
        "새로운 아침이 밝았습니다!",
      );
    } else if (updated == "weekly") {
      updateMessageDialog(
        weeklyReset,
        "주간 초기화",
        "이번주도 힘내봅시다!",
      );
    }
  }

  void dailyReset() {
    context.read<MealProvider>().initialized(true);
  }

  void weeklyReset() {
    dailyReset();
    context.read<TraningProvider>().initialized(true);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    onCheckUpdate();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onCheckUpdate();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await MessageSystem.initWillPopMessage(context);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(left: 44 * getScaleFactorFromWidth(context)),
              child: IndexedStack(
                index: selectedMenuIndex,
                children: const [
                  Info(),
                  Traning(),
                  Meal(),
                  Calendar(),
                  Settings(),
                ],
              ),
            ),
            SideBar(
              onPressMenuIcon: setSelectedMenuIndex,
              selectedMenuIndex: selectedMenuIndex,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
