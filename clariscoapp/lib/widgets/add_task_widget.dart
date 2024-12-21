import 'package:clariscoapp/core/utils/globle_colors.dart';
import 'package:flutter/material.dart';

class CustomAddCardWidget extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final double elevation;
  const CustomAddCardWidget(
      {super.key,
      required this.child,
      this.bgColor = GlobalColors.primaryWhite,
      this.elevation = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow:const [
              BoxShadow(
                  color: GlobalColors.appbgColor,
                  blurRadius: 5,
                  spreadRadius: 5,
                  offset: Offset(3, 3))
            ]),
        margin: const EdgeInsets.only(bottom: 20, top: 10),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: child,
        ));
  }
}
