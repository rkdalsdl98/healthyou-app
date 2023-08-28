import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healthyou_app/provider/calendar_provider.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/provider/notify_provider.dart';
import 'package:healthyou_app/provider/traning_provider.dart';
import 'package:healthyou_app/provider/user_provider.dart';
import 'package:healthyou_app/repository/calendar_repository.dart';
import 'package:healthyou_app/repository/meal_repository.dart';
import 'package:healthyou_app/repository/notify_repository.dart';
import 'package:healthyou_app/repository/traning_repository.dart';
import 'package:healthyou_app/repository/user_repository.dart';
import 'package:healthyou_app/view/loading.dart';
import 'package:healthyou_app/view/routes.dart';
import 'package:healthyou_app/view/welcome.dart';
import 'package:provider/provider.dart';

import '../design/color_schemes.g.dart';
import 'home.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(repository: UserRepository())),
        ChangeNotifierProvider<NotifyProvider>(
            create: (_) => NotifyProvider(repository: NotifyRepository())),
        ChangeNotifierProvider<CalendarProvider>(
            create: (_) => CalendarProvider(repository: CalendarRepository())),
        ChangeNotifierProvider<TraningProvider>(
          create: (_) =>
              TraningProvider(false, repository: TraningRepository()),
        ),
        ChangeNotifierProvider<MealProvider>(
          create: (_) => MealProvider(false, repository: MealRepository()),
        ),
      ],
      builder: ((context, _) => MaterialApp(
            title: 'Healthyou',
            theme: ThemeData(
              colorScheme: lightColorScheme,
              useMaterial3: true,
            ),
            supportedLocales: const [
              Locale('ko', 'KR'),
              Locale('en', 'US'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateRoute: (settings) =>
                initGeneratedRoutes(settings, context),
            home: const Loading(),
          )),
    );
  }
}
