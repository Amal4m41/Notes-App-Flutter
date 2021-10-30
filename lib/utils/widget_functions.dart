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
      content: Text(message),
      backgroundColor: Colors.red.shade400,
    ),
  );
}
