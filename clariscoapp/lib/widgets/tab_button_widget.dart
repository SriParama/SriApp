import 'package:flutter/material.dart';

import '../core/utils/globle_colors.dart';

class TabContainerWidget extends StatelessWidget {
  final bool isSelected;
  final String text;
  const TabContainerWidget(
      {super.key, required this.isSelected, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,

      color: isSelected
          ? GlobalColors.appPrimaryButtonColor // Selected color
          : Colors.transparent, // Default color
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Text(
          text,
          style: TextStyle(
              color: isSelected
                  ? GlobalColors.primaryWhite
                  : GlobalColors.primaryTextColor,
              fontSize: 12),
        ),
      ),
    );
  }
}
