import 'package:flutter/material.dart';

import '../../../../design/dimensions.dart';
import '../../../global/scale_anim_square.dart';

class HistoryItem extends StatelessWidget {
  final String time;
  final int index;
  final bool res;

  const HistoryItem({
    super.key,
    required this.time,
    required this.index,
    required this.res,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ScaleAnimSquare(
          curve: Curves.fastOutSlowIn,
          size: 18,
          borderWidth: 3,
          duration: const Duration(milliseconds: 600),
        ),
        SizedBox(width: 10 * getScaleFactorFromWidth(context)),
        Text(
          '$time PM',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
            fontSize: 10 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          res ? ' ${index + 1} 번째 식사를 했습니다.' : ' ${index + 1} 번째 식사를 하지 못했습니다.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: res
                ? Theme.of(context).colorScheme.onBackground.withOpacity(.5)
                : Theme.of(context).colorScheme.error.withOpacity(.6),
            fontSize: 10 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
