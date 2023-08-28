import 'package:flutter/material.dart';

import '../../design/dimensions.dart';

class ScaleAnimIcon extends StatefulWidget {
  final Curve curve;
  final Duration duration;
  final double size;
  final IconData icon;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Color? color;

  ScaleAnimIcon({
    super.key,
    required this.curve,
    required this.duration,
    required this.size,
    this.color,
    required this.icon,
    this.padding,
    this.margin,
  });

  @override
  State<ScaleAnimIcon> createState() => _ScaleAnimIconState();
}

class _ScaleAnimIconState extends State<ScaleAnimIcon>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        padding: widget.padding,
        margin: widget.margin,
        child: Icon(
          widget.icon,
          size: widget.size * getScaleFactorFromWidth(context),
          color: widget.color,
        ),
      ),
    );
  }
}
