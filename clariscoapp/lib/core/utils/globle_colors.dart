import 'dart:math';

import 'package:flutter/material.dart';

class GlobalColors {
  static const Color appbgColor = Color.fromRGBO(238, 238, 238, 0.7);
  static const Color appPrimaryColor = Color.fromRGBO(247, 241, 255, 1);
  static const Color appSecondryColor = Color.fromRGBO(123, 16, 218, 1);
  static const Color appPrimaryButtonColor = Color.fromRGBO(2, 12, 48, 1);
  static const Color appPrimaryTitleColor = Color.fromRGBO(30, 75, 184, 1);
  static const Color primaryTextColor = Color.fromRGBO(35, 35, 35, 1);
  static const Color primaryWhite = Colors.white;

  static Color getRandomBrightColor() {
    final random = Random();

    final List<Color> baseColors = [
      Colors.red,
      Colors.pink,

      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.grey,
      Colors.blueGrey,
    ];

    // Randomly select one color from the list
    return baseColors[random.nextInt(baseColors.length)];
  }

  static IconData getRandomIcon() {
    final random = Random();

    // Define the base colors for light yellow, light blue, light purple, light pink, and light orange
    final List<IconData> baseColors = [
      Icons.verified,
      Icons.star,
      Icons.gps_fixed_rounded,
      Icons.local_fire_department_sharp,
      Icons.file_open_rounded,
    ];

    // Randomly select one color from the list
    return baseColors[random.nextInt(baseColors.length)];
  }

  // Singleton for easy access
  static final GlobalColors _instance = GlobalColors._internal();
  factory GlobalColors() => _instance;
  GlobalColors._internal();
}
