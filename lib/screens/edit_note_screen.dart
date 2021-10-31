import 'package:flutter/material.dart';
import 'package:notes_app/components/capsule_text_border.dart';
import 'package:notes_app/components/note_screen_template.dart';
import 'package:notes_app/components/round_icon_border.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/screens/create_note_screen.dart';
import 'package:notes_app/utils/constants.dart';
import 'package:notes_app/utils/widget_functions.dart';

class EditNoteScreen extends StatefulWidget {
  static const String id = "EditNoteScreen";

  final Note note;

  EditNoteScreen({required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
  }

  @override
  Widget build(BuildContext context) {
    return NoteScreenTemplate(
      titleController: titleController,
      descriptionController: descriptionController,
      editable: false,
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
              String title = titleController.text;
              String description = descriptionController.text;

              if (title.trim().isEmpty) {
                showErrorSnackBar(context, "Title can't be empty");
              } else {
                description = description.trim().isEmpty ? "" : description;
                // await NotesDatabase.instance.update(
                //   widget.note.copy(
                //     title: title,
                //     description: description,
                //     createdTime: DateTime.now(),
                //   ),
                // );
                // Navigator.pop(context, "Updated");
                // print(title);
                // print(description);
                // print(widget.note.id);
                final DbNoteAction? result = await Navigator.pushNamed(
                    context, CreateNoteScreen.id,
                    arguments: CreateNoteScreenArguments(
                        title: title,
                        description: description,
                        noteId: widget.note.id)) as DbNoteAction?;

                Navigator.pop(context, result); //return to homescreen
              }
            },
          ),
          getHorizontalSpace(5),
          InkWell(
            child: RoundIconBorder(icon: Icons.delete),
            onTap: () async {
              await NotesDatabase.instance.delete(widget.note.id!);
              Navigator.pop(context, DbNoteAction.delete);
            },
          ),
        ],
      ),
    );
  }
}

class EditNoteScreenArguments {
  final Note note;

  EditNoteScreenArguments({required this.note});
}
