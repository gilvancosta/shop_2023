import 'package:flutter/material.dart';



mixin SnackBarMixin {
  void showSnackBar(text, {required BuildContext context, bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
        ),
      );
  }
}
