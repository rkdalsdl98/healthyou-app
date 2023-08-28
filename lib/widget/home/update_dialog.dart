import 'package:flutter/material.dart';

import '../../design/dimensions.dart';
import '../global/rounded_button_medium.dart';

class UpdateDialog extends StatelessWidget {
  final String title;
  final String text;
  final Function() onPressEvent;
  final Function(int) setPage;

  const UpdateDialog({
    super.key,
    required this.title,
    required this.text,
    required this.onPressEvent,
    required this.setPage,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 100),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.maxFinite,
        height: 100 * getScaleFactorFromHeight(context),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Theme.of(context).colorScheme.shadow.withOpacity(.25),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 12 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 10 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: RoundedButtonMedium(
                text: "확인",
                onPressEvent: () {
                  onPressEvent();
                  setPage(0);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
