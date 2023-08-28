import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/meal_provider.dart';
import 'package:healthyou_app/widget/home/meal/history/history_item.dart';
import 'package:healthyou_app/widget/home/meal/history/history_item_with_line.dart';
import 'package:provider/provider.dart';

import '../../../../design/dimensions.dart';

class MealHistory extends StatelessWidget {
  const MealHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '히스토리',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Consumer<MealProvider>(builder: (_, provider, __) {
            return Container(
              width: 240 * getScaleFactorFromWidth(context),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var history in provider.historys)
                    history.index == 0
                        ? HistoryItem(
                            time: history.time!,
                            index: history.index!,
                            res: history.result!,
                          )
                        : HistoryItemWithLine(
                            animSeconds: 1,
                            time: history.time!,
                            index: history.index!,
                            res: history.result!,
                          )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
