import 'package:flutter/material.dart';
import 'package:healthyou_app/provider/user_provider.dart';
import 'package:healthyou_app/system/message_system.dart';
import 'package:healthyou_app/widget/welcome/first_welcome_page.dart';
import 'package:healthyou_app/widget/welcome/last_welcome_page.dart';
import 'package:healthyou_app/widget/welcome/second_welcome_page.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  bool showingPage;

  Welcome({
    super.key,
    this.showingPage = true,
  });

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController controller = PageController();
  int page = 0;
  Map<String, dynamic> result = {};

  setCurrentResult(Map<String, dynamic> datas) {
    datas.updateAll((_, value) {
      if (value == "" || value == null) {
        return null;
      }
      return int.parse(value);
    });
    result = datas;
    moveNextPage();
  }

  moveNextPage() {
    ++page;
    if (page == 2) {
      controller.animateToPage(
        3,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  startHealthyou() {
    final provider = context.read<UserProvider>();
    provider.updateInfo(result);
    Navigator.popAndPushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await MessageSystem.initWillPopMessage(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FirstWelcomePage(
              onPressEvent: moveNextPage,
              showingPage: widget.showingPage,
            ),
            SecondWelcomePage(onPressEvent: setCurrentResult),
            LastWelcomePage(onPressEvent: startHealthyou),
          ],
        ),
      ),
    );
  }
}
