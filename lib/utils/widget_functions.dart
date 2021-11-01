import 'package:flutter/material.dart';

SizedBox getVerticalSpace(double value) {
  return SizedBox(
    height: value,
  );
}

SizedBox getHorizontalSpace(double value) {
  return SizedBox(
    width: value,
  );
}

//Error/Warning Snackbar

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red.shade400,
    ),
  );
}

void showSnackBarWithAction(
    {required BuildContext context,
    required String message,
    required VoidCallback onPressed}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 10,
      duration: const Duration(seconds: 2),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: "Undo",
        onPressed: onPressed,
        textColor: Colors.white,
      ),
    ),
  );
}
