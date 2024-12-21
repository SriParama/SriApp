
import 'package:clariscoapp/core/utils/globle_colors.dart';
import 'package:flutter/material.dart';

appExit(context, String exitMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.up,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
          left: MediaQuery.of(context).size.width * 0.30,
          right: MediaQuery.of(context).size.width * 0.30),
      backgroundColor: Colors.grey,
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      duration: const Duration(seconds: 2),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10.0,
          ),
          Text(
            exitMessage,
            style: TextStyle(fontSize: 14.0, color: GlobalColors.primaryWhite),
          )
        ],
      )));
}
