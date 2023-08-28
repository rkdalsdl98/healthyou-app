import 'package:flutter/material.dart';

import '../../design/dimensions.dart';

class DefaultDropDownButton extends StatefulWidget {
  String currValue;
  final Function(String) setCurrValue;
  final List<String> items;

  DefaultDropDownButton({
    super.key,
    required this.currValue,
    required this.setCurrValue,
    required this.items,
  });

  @override
  State<DefaultDropDownButton> createState() => _DefaultDropDownButtonState();
}

class _DefaultDropDownButtonState extends State<DefaultDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: widget.items
          .map<DropdownMenuItem<String>>(
            (category) => DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            ),
          )
          .toList(),
      icon: Align(
        alignment: Alignment.topLeft,
        child: RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.play_arrow_rounded,
            size: 8 * getScaleFactorFromWidth(context),
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
          ),
        ),
      ),
      onChanged: (v) {
        widget.currValue = v ?? widget.currValue;
        widget.setCurrValue(widget.currValue);
      },
      elevation: 0,
      underline: Container(decoration: const BoxDecoration(border: Border())),
      alignment: Alignment.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
        fontSize: 8 * getScaleFactorFromWidth(context),
        fontFamily: 'SpoqaHanSans',
        fontWeight: FontWeight.w600,
      ),
      value: widget.currValue,
    );
  }
}
