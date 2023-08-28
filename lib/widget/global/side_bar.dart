import 'package:flutter/material.dart';
import 'package:healthyou_app/widget/global/side_bar_menu_button.dart';

import '../../design/dimensions.dart';

class SideBar extends StatefulWidget {
  final Function(int) onPressMenuIcon;
  int selectedMenuIndex;

  SideBar({
    super.key,
    required this.onPressMenuIcon,
    required this.selectedMenuIndex,
  });

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  double sidebarWidth = 44;
  bool sidebarArrowForward = true;
  bool showDetail = false;

  Future<void> setShowText() async {
    await Future.delayed(const Duration(milliseconds: 350));
    setState(() {
      showDetail = !showDetail;
    });
  }

  void onPressdArrowButton() {
    setState(() {
      if (sidebarArrowForward) {
        sidebarWidth = 200;
      } else {
        sidebarWidth = 44;
      }
      sidebarArrowForward = !sidebarArrowForward;
      setShowText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: sidebarWidth * getScaleFactorFromWidth(context),
      decoration: BoxDecoration(
        border: const Border(right: BorderSide()),
        color: Theme.of(context).colorScheme.background,
      ),
      curve: Curves.fastOutSlowIn,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 20 * getScaleFactorFromHeight(context)),
              SideBarMenuButton(
                showDetail: showDetail,
                onPressEvent: widget.onPressMenuIcon,
                selectedMenuIndex: widget.selectedMenuIndex,
                icon: Icons.person,
                text: "Profile",
                index: 0,
              ),
              SideBarMenuButton(
                showDetail: showDetail,
                onPressEvent: widget.onPressMenuIcon,
                selectedMenuIndex: widget.selectedMenuIndex,
                icon: Icons.directions_run,
                text: "Tranning",
                index: 1,
              ),
              SideBarMenuButton(
                showDetail: showDetail,
                onPressEvent: widget.onPressMenuIcon,
                selectedMenuIndex: widget.selectedMenuIndex,
                icon: Icons.rice_bowl,
                text: "Food",
                index: 2,
              ),
              SideBarMenuButton(
                showDetail: showDetail,
                onPressEvent: widget.onPressMenuIcon,
                selectedMenuIndex: widget.selectedMenuIndex,
                icon: Icons.calendar_today_outlined,
                text: "Calendar",
                index: 3,
              ),
              SideBarMenuButton(
                showDetail: showDetail,
                onPressEvent: widget.onPressMenuIcon,
                selectedMenuIndex: widget.selectedMenuIndex,
                icon: Icons.settings,
                text: "Settings",
                index: 4,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () => onPressdArrowButton(),
              icon: Icon(
                sidebarArrowForward
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.arrow_back_ios_rounded,
                size: 18 * getScaleFactorFromWidth(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
