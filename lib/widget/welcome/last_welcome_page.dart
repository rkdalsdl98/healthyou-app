import 'package:flutter/material.dart';
import 'package:healthyou_app/widget/global/long_text_button.dart';

import '../../design/dimensions.dart';

class LastWelcomePage extends StatelessWidget {
  final Function() onPressEvent;

  const LastWelcomePage({
    super.key,
    required this.onPressEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(flex: 2),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Healthyou !",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 40 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.5),
                    fontSize: 12 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w600,
                  ),
                  text:
                      "어플을 사용하기 위한 모든 준비를 마쳤습니다!\n지금부터는 여러분이 스스로 계획을 세우고\n목표를 달성하는 일만 남았습니다!\n\n",
                  children: const [
                    TextSpan(text: "앞으로에 근성장, 다이어트를 응원합니다!"),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: LongTextButton(
            text: "시작하기",
            onPressEvent: onPressEvent,
          ),
        ),
      ],
    );
  }
}
