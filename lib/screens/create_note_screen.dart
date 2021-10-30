import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/capsule_text_border.dart';
import 'package:notes_app/components/round_icon_border.dart';

class CreateNoteScreen extends StatelessWidget {
  static const String id = "CreateNoteScreen";

  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: RoundIconBorder(icon: Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    child: CapsuleTextBorder(text: "Save"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
