import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/calendar_provider.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/provider/notify_provider.dart';
import 'package:healthyou_app/provider/traning_provider.dart';
import 'package:healthyou_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../design/dimensions.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late RiveAnimationController _controller;
  late Timer timer;

  int loadTextDots = 14;

  Future<void> moveToHome() async {
    await Future.delayed(const Duration(seconds: 3)).then((_) =>
        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false));
  }

  Future<void> moveToWelcome() async {
    await Future.delayed(const Duration(seconds: 3)).then((_) =>
        Navigator.pushNamedAndRemoveUntil(context, '/welcome', (_) => false));
  }

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'bounce',
      autoplay: true,
    );
    timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      if (loadTextDots == 14) {
        loadTextDots = 11;
      } else {
        ++loadTextDots;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          RiveAnimation.asset(
            'assets/rive/healthyou_logo.riv',
            controllers: [_controller],
            animations: const ['BounceLogo'],
            fit: BoxFit.fitWidth,
          ),
          Consumer5<UserProvider, TraningProvider, MealProvider,
                  CalendarProvider, NotifyProvider>(
              builder: (_, user, traning, meal, calendar, notify, __) {
            int isReadys = 0;
            for (var e in [
              user.isReady,
              traning.isReady,
              meal.isReady,
              calendar.isReady,
              notify.isReady
            ]) {
              e ? ++isReadys : null;
            }

            String loadCountText = "$isReadys/5";
            String loadingText =
                "${"잠시만 기다려 주세요".padRight(loadTextDots, ".")} $loadCountText";

            if (isReadys >= 5) {
              timer.cancel();
              loadingText = "준비가 완료되었어요!";
              if (user.info != null) {
                moveToHome();
              } else {
                moveToWelcome();
              }
            }

            return Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                loadingText,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.5),
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
