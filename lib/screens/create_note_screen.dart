import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/capsule_text_border.dart';
import 'package:notes_app/components/note_screen_template.dart';
import 'package:notes_app/components/round_icon_border.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/utils/constants.dart';
import 'package:notes_app/utils/widget_functions.dart';

class CreateNoteScreen extends StatefulWidget {
  static const String id = "CreateNoteScreen";

  //If note id it passed then it's an update operation instead of create.
  final int? noteId;
  final String title;
  final String description;

  const CreateNoteScreen({this.title = '', this.description = '', this.noteId});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return NoteScreenTemplate(
      titleController: titleController,
      descriptionController: descriptionController,
      // title: title,
      // description: description,
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
              String title = titleController.text;
              String description = descriptionController.text;
              //If the left most condition is true, then the next condition won't be checked ...therefore it won't throw null exception.
              if (title.trim().isEmpty) {
                showErrorSnackBar(context, "Title can't be empty");
              } else {
                //If the string just container white spaces then replace it with an empty string to save storage.
                description = description.trim().isEmpty ? '' : description;

                if (widget.noteId == null) {
                  Note note = await NotesDatabase.instance.insertNote(
                    Note(
                      title: title,
                      description: description,
                      createdTime: DateTime.now(),
                    ),
                  );

                  Navigator.pop(context, DbNoteAction.insert);
                } else {
                  int result = await NotesDatabase.instance.update(
                    Note(
                      id: widget.noteId!,
                      title: title,
                      description: description,
                      createdTime: DateTime.now(),
                    ),
                  );
                  Navigator.pop(context, DbNoteAction.update);
                }
                // print(title);
                // print(description);
              }
            },
          ),
        ],
      ),
    );
  }
}

class CreateNoteScreenArguments {
  final int? noteId;
  final String title;
  final String description;

  CreateNoteScreenArguments(
      {this.title = '', this.description = '', this.noteId});
}
