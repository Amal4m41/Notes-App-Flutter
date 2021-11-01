import 'package:flutter/material.dart';
import 'package:notes_app/utils/widget_functions.dart';

class NotesEmptyMessage extends StatelessWidget {
  const NotesEmptyMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("📝", style: TextStyle(fontSize: 50)),
        getVerticalSpace(40),
        const Text(
          "No notes to display ☹",
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          "Click on  ' + '  to add a note",
          style: TextStyle(fontSize: 20),
        ),
        getVerticalSpace(60),
      ],
    );
  }
}
