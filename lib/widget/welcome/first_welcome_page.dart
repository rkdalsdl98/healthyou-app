import 'package:flutter/material.dart';

import '../../design/dimensions.dart';
import '../global/long_text_button.dart';

class FirstWelcomePage extends StatefulWidget {
  final Function() onPressEvent;
  final bool showingPage;
  const FirstWelcomePage({
    super.key,
    required this.onPressEvent,
    required this.showingPage,
  });

  @override
  State<FirstWelcomePage> createState() => _FirstWelcomePageState();
}

class _FirstWelcomePageState extends State<FirstWelcomePage> {
  double titleOpacaity = 0;
  bool moveTitle = false;

  double textOpacity = 0;
  double buttonOpacity = 0;

  showText() {
    setState(() {
      textOpacity = 1;
      buttonOpacity = 1;
    });
  }

  showTitle() async {
    setState(() {
      titleOpacaity = 1;
      moveTitle = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    showText();
  }

  show() async {
    await Future.delayed(const Duration(milliseconds: 500));
    showTitle();
  }

  @override
  void initState() {
    super.initState();
    if (widget.showingPage) {
      show();
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleOpacaity = 0;
    moveTitle = false;
    textOpacity = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AnimatedOpacity(
                    opacity: titleOpacaity,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedAlign(
                      alignment: moveTitle
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      child: RichText(
                        text: TextSpan(
                          text: "Welcome\n",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 40 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w800,
                          ),
                          children: const [
                            TextSpan(text: "To\n"),
                            TextSpan(text: "Healthyou !"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: textOpacity,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(.5),
                              fontSize: 16 * getScaleFactorFromWidth(context),
                              fontFamily: 'SpoqaHanSans',
                              fontWeight: FontWeight.w600,
                            ),
                            text: "Healthyou를 선택해주셔서 감사합니다!\n",
                            children: const [
                              TextSpan(
                                  text:
                                      "건강한 당신, 건강은 당신을 지켜본다는 이중적인 의미를 담은 이름을 가진 만큼 최대한 그에 걸맞은 환경을 조성하도록 노력하겠습니다!"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Healthyou는 여러분의 각자의 목표를 존중하고, 원활히 관리 하는것에 도움을 드리고자 만들게된\nTo-Do List 어플리케이션 입니다.",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.5),
                            fontSize: 16 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "해당 어플리케이션에 사용되는 정보는 현재는 따로 서버에 저장되지 않고 기기에 저장됩니다.",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.5),
                            fontSize: 16 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "다음으로 넘어가기 위해 버튼을 눌러주세요.",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.5),
                            fontSize: 16 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AnimatedOpacity(
              opacity: buttonOpacity,
              duration: const Duration(milliseconds: 500),
              child: LongTextButton(
                text: "다음",
                onPressEvent: widget.onPressEvent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
