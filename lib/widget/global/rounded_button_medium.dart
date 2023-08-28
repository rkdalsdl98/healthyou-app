import 'package:flutter/material.dart';

import '../../design/dimensions.dart';

class RoundedButtonMedium extends StatelessWidget {
  final String text;
  final Function()? onPressEvent;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Color? buttonColor;
  Color? textColor;
  double borderWidth;

  RoundedButtonMedium({
    super.key,
    required this.text,
    this.onPressEvent,
    this.padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    this.margin,
    this.buttonColor,
    this.textColor,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressEvent,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: buttonColor ?? Theme.of(context).colorScheme.background,
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(180),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(.25),
              offset: const Offset(0, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ??
                Theme.of(context).colorScheme.onBackground.withOpacity(.5),
            fontSize: 10 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
