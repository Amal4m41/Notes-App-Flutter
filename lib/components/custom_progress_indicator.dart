import 'package:flutter/material.dart';
import 'package:notes_app/utils/widget_functions.dart';

class CustomProgressIndicator extends StatelessWidget {
  final String textMsg;

  CustomProgressIndicator({required this.textMsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colors.greenAccent,
              strokeWidth: 4,
            ),
            getHorizontalSpace(25),
            Text(textMsg),
          ],
        ),
      ),
    );
  }
}
