import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/capsule_text_border.dart';
import 'package:notes_app/components/note_screen_template.dart';
import 'package:notes_app/components/round_icon_border.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/utils/widget_functions.dart';

class CreateNoteScreen extends StatefulWidget {
  static const String id = "CreateNoteScreen";

  final String? title;
  final String? description;

  const CreateNoteScreen({this.title = null, this.description = null});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  String? title;
  String? description;

  @override
  void initState() {
    super.initState();

    title = widget.title;
    description = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return NoteScreenTemplate(
      title: title,
      description: description,
      toolbar: Row(
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
            onTap: () async {
              //If the left most condition is true, then the next condition won't be checked ...therefore it won't throw null exception.
              if (title == null || title!.trim().isEmpty) {
                showErrorSnackBar(context, "Title can't be empty");
              } else {
                //If description is null, then assign it with an empty string before storing in db.
                description ??= "";
                Note note = await NotesDatabase.instance.insertNote(
                  Note(
                    title: title!,
                    description: description!,
                    createdTime: DateTime.now(),
                  ),
                );
                Navigator.pop(context, "Saved");
              }
            },
          ),
        ],
      ),
      onChangedTitleText: (String titleValue) {
        title = titleValue;
      },
      onChangedDescriptionText: (String descriptionValue) {
        description = descriptionValue;
      },
    );
  }
}
