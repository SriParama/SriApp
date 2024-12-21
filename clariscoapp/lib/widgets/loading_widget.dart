import 'package:flutter/material.dart';

loadingDailogWithCircle(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
          child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              )));
    },
  );
}