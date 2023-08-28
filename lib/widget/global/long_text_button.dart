import 'package:flutter/material.dart';

import '../../design/dimensions.dart';

class LongTextButton extends StatelessWidget {
  final String text;
  Function()? onPressEvent;

  LongTextButton({
    super.key,
    required this.text,
    this.onPressEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      width: 300 * getScaleFactorFromWidth(context),
      height: 30 * getScaleFactorFromWidth(context),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.25),
            offset: const Offset(0, 4),
            blurRadius: 4,
          )
        ],
      ),
      child: InkWell(
        onTap: onPressEvent,
        child: SizedBox(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 12 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
