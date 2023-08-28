import 'package:flutter/material.dart';
import 'package:healthyou_app/widget/home/meal/history/history_item.dart';

import '../../../../design/dimensions.dart';

class HistoryItemWithLine extends StatefulWidget {
  final int animSeconds;
  final int index;
  final bool res;
  final String time;

  const HistoryItemWithLine({
    super.key,
    required this.animSeconds,
    required this.time,
    required this.index,
    required this.res,
  });

  @override
  State<HistoryItemWithLine> createState() => _HistoryItemWithLineState();
}

class _HistoryItemWithLineState extends State<HistoryItemWithLine> {
  bool showItem = false;
  int height = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0)).then((_) {
      setState(() {
        height = 30;
      });
    });
    Future.delayed(Duration(seconds: widget.animSeconds)).then((_) {
      setState(() {
        showItem = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: Duration(seconds: widget.animSeconds),
          curve: Curves.fastEaseInToSlowEaseOut,
          margin: const EdgeInsets.only(left: 5),
          width: 8 * getScaleFactorFromWidth(context),
          height: height * getScaleFactorFromWidth(context),
          color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
        ),
        if (showItem)
          HistoryItem(
            time: widget.time,
            index: widget.index,
            res: widget.res,
          ),
      ],
    );
  }
}
