import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final Widget child;
  final bool isHomePage;
  final Color? color;
  final bool? isRoundTop;

  ContainerWidget(
      {required this.child,
      this.isHomePage = false,
      this.color,
      this.isRoundTop = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).backgroundColor,
        borderRadius: isRoundTop!
            ? BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft:
                    isHomePage ? Radius.circular(20) : Radius.circular(0),
                bottomRight:
                    isHomePage ? Radius.circular(20) : Radius.circular(0),
              )
            : null,
      ),
      child: child,
    );
  }
}
