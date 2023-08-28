import 'package:flutter/material.dart';
import 'package:healthyou_app/view/root.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const RootView());
}
