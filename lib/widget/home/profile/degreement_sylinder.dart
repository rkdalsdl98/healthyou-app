import 'package:flutter/material.dart';
import 'package:healthyou_app/model/traning/traning_schedule_model.dart';

import '../../../design/dimensions.dart';
import '../../../types/date_types.dart';

class DegreementSylinder extends StatefulWidget {
  final TraningScheduleModel schedule;

  const DegreementSylinder({
    super.key,
    required this.schedule,
  });

  @override
  State<DegreementSylinder> createState() => _DegreementSylinderState();
}

class _DegreementSylinderState extends State<DegreementSylinder>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _animation = Tween<double>(
    begin: 1,
    end: 1.1,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ),
  );

  late final int maxValue = widget.schedule.schedule == null
      ? 10
      : widget.schedule.schedule!.presetItems!.length;

  bool focusedItem = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void forwardAnim() {
    setState(() {
      _controller.forward();
      focusedItem = true;
    });
  }

  void backwardAnim() {
    setState(() {
      _controller.reverse();
      focusedItem = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedOpacity(
              opacity: focusedItem ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Text(
                widget.schedule.completes! >= maxValue
                    ? "모두 달성!"
                    : "${widget.schedule.completes}개 달성!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize:
                      (7 * getScaleFactorFromWidth(context)) * _animation.value,
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onLongPress: forwardAnim,
              onLongPressUp: backwardAnim,
              child: Container(
                width:
                    (10 * getScaleFactorFromWidth(context)) * _animation.value,
                height:
                    (90 * getScaleFactorFromHeight(context)) * _animation.value,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(180),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.25),
                    ),
                    if (focusedItem)
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: const Offset(0, 0),
                        color: Theme.of(context).colorScheme.background,
                      ),
                  ],
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()
                    ..setEntry(
                        1, 1, ((widget.schedule.completes ?? 0) / maxValue)),
                  transformAlignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(180),
                  ),
                ),
              ),
            ),
            Text(
              widget.schedule.daily!.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: DateTypes.DAYS[DateTime.now().weekday] ==
                        widget.schedule.daily!
                    ? Colors.yellow
                    : Theme.of(context).colorScheme.background,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                    color: DateTypes.DAYS[DateTime.now().weekday] ==
                            widget.schedule.daily!
                        ? Colors.yellow
                        : Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.8),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
