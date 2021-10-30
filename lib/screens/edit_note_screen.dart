import 'package:flutter/material.dart';
import 'package:notes_app/components/capsule_text_border.dart';
import 'package:notes_app/components/note_screen_template.dart';
import 'package:notes_app/components/round_icon_border.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/utils/widget_functions.dart';

class EditNoteScreen extends StatefulWidget {
  static const String id = "EditNoteScreen";

  final Note note;

  EditNoteScreen({required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.note.title;
    description = widget.note.description;
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
          Expanded(
            child: Container(),
          ),
          InkWell(
            child: RoundIconBorder(icon: Icons.edit),
            onTap: () async {
              if (title.trim().isEmpty) {
                showErrorSnackBar(context, "Title can't be empty");
              } else {
                description = description.trim().isEmpty ? "" : description;
                await NotesDatabase.instance.update(
                  widget.note.copy(
                    title: title,
                    description: description,
                    createdTime: DateTime.now(),
                  ),
                );
                Navigator.pop(context, "Updated");
              }
            },
          ),
          getHorizontalSpace(5),
          InkWell(
            child: RoundIconBorder(icon: Icons.delete),
            onTap: () async {
              await NotesDatabase.instance.delete(widget.note.id!);
              Navigator.pop(context, "Deleted");
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

class EditNoteScreenArguments {
  final Note note;

  EditNoteScreenArguments({required this.note});
}
