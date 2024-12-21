import 'package:flutter/material.dart';

import '../core/utils/globle_colors.dart';

class CustomMaterialButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  const CustomMaterialButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.elevation = 2.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.textStyle,
  });

  @override
  State<CustomMaterialButton> createState() => _CustomMaterialButtonState();
}

class _CustomMaterialButtonState extends State<CustomMaterialButton>
      {


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      color: widget.color,
      elevation: widget.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      padding: widget.padding,
      materialTapTargetSize:
          MaterialTapTargetSize.shrinkWrap, 
        
      child: Text(
        widget.text,
        style: widget.textStyle ??
            const TextStyle(
              color: GlobalColors.appPrimaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
