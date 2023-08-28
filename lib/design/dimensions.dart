import 'package:flutter/material.dart';

const baseWidth = 360;
const baseHeight = 740;

double getScaleFactorFromWidth(BuildContext context) {
  return (MediaQuery.of(context).size.width / baseWidth);
}

double getScaleFactorFromHeight(BuildContext context) {
  return (MediaQuery.of(context).size.height / baseHeight);
}
