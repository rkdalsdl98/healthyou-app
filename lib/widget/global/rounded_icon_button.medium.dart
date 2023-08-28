import 'package:flutter/material.dart';

import '../../design/dimensions.dart';

class RoundedIconButtonMedium extends StatelessWidget {
  final Icon icon;
  final Function()? onPressEvent;
  final Function()? onLongPressDown;
  final Function()? onLongPressUp;
  EdgeInsetsGeometry? margin;

  RoundedIconButtonMedium({
    super.key,
    required this.icon,
    this.onPressEvent,
    this.onLongPressDown,
    this.onLongPressUp,
    this.margin = const EdgeInsets.only(right: 10),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressEvent,
      onLongPressDown: (details) {
        if (onLongPressDown != null) {
          onLongPressDown!();
        }
      },
      onLongPressUp: onLongPressUp,
      child: Container(
        margin: margin,
        width: 18 * getScaleFactorFromWidth(context),
        height: 18 * getScaleFactorFromWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(180),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(.25),
              offset: const Offset(0, 1),
              blurRadius: 1,
            )
          ],
        ),
        child: icon,
      ),
    );
  }
}
