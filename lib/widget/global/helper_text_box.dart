import 'package:flutter/material.dart';

import '../../design/dimensions.dart';

class HelperTextBox extends StatelessWidget {
  final String text;
  double width;

  HelperTextBox({
    super.key,
    this.width = 90,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * getScaleFactorFromWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFD9DDEB),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.25),
            offset: const Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFF93969F),
          fontSize: 5 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
