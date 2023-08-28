import 'package:flutter/material.dart';
import 'package:healthyou_app/model/traning/traning_schedule_model.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/provider/traning_provider.dart';
import 'package:healthyou_app/view/home.dart';
import 'package:healthyou_app/view/loading.dart';
import 'package:healthyou_app/view/meal/register_meal.dart';
import 'package:healthyou_app/view/traning/schedule_detail.dart';
import 'package:healthyou_app/view/welcome.dart';
import 'package:provider/provider.dart';

Route<dynamic>? initGeneratedRoutes(
    RouteSettings settings, BuildContext context) {
  final args =
      (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const Loading());
    case '/welcome':
      return MaterialPageRoute(builder: (_) => Welcome());
    case '/home':
      return MaterialPageRoute(builder: (_) => const Home());
    case '/schedule-detail':
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<TraningProvider>.value(
          value: context.read<TraningProvider>(),
          child: ScheduleDetail(schedule: TraningScheduleModel.fromJson(args)),
        ),
      );
    case '/register-meal':
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<MealProvider>.value(
          value: context.read<MealProvider>(),
          child: const RegisterMeal(),
        ),
      );
    default:
      return null;
  }
}
