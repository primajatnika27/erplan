import 'package:flutter/material.dart';

class CircleBarWidget extends StatelessWidget {
  final int length;
  final int activeIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double size;
  final double spaceBetween;
  final Duration duration;
  final EdgeInsets padding;

  CircleBarWidget({
    required this.length,
    required this.activeIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.size,
    this.spaceBetween = 10,
    this.duration = const Duration(milliseconds: 250),
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < length; i++) ...[
            AnimatedContainer(
              duration: duration,
              height: size,
              width: i == activeIndex ? size * 4 : size,
              decoration: BoxDecoration(
                color: i == activeIndex ? activeColor : inactiveColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(size),
                ),
              ),
            ),
            if (i < length - 1) ...[
              SizedBox(
                width: spaceBetween,
              ),
            ],
          ],
        ],
      ),
    );
  }
}
