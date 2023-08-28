import 'package:flutter/material.dart';

import '../../design/dimensions.dart';

class SideBarMenuButton extends StatelessWidget {
  final Function(int) onPressEvent;
  final int selectedMenuIndex;
  final int index;
  final IconData icon;
  final bool showDetail;
  final String text;

  const SideBarMenuButton({
    super.key,
    required this.showDetail,
    required this.onPressEvent,
    required this.selectedMenuIndex,
    required this.index,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color color = selectedMenuIndex == index
        ? const Color(0xFF1CBA3E)
        : Theme.of(context).colorScheme.secondary;
    Color iconColor = selectedMenuIndex == index
        ? Theme.of(context).colorScheme.onBackground
        : Theme.of(context).colorScheme.secondary;

    return InkWell(
      onTap: () => onPressEvent(index),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              size: 20 * getScaleFactorFromWidth(context),
              color: iconColor,
            ),
          ),
          if (showDetail)
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: iconColor,
                fontSize: 12 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
              ),
            ),
          if (showDetail)
            Container(
              margin: const EdgeInsets.only(right: 20),
              width: 6 * getScaleFactorFromWidth(context),
              height: 6 * getScaleFactorFromWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: color,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
