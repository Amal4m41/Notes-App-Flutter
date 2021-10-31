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
  final int colorIndex;

  const CreateNoteScreen(
      {this.title = '',
      this.description = '',
      this.noteId,
      this.colorIndex = 0});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late int selectedColor; //stores the index of the color from color list.

  @override
  void initState() {
    super.initState();

    titleController.text = widget.title;
    descriptionController.text = widget.description;
    selectedColor = widget.colorIndex;
    print(selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return NoteScreenTemplate(
      titleController: titleController,
      descriptionController: descriptionController,
      selectedColor: noteColors[selectedColor],
      callback: (Color value) {
        setState(() {
          selectedColor = noteColors.indexOf(value);
        });
        Navigator.pop(context);
      },
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
                      colorIndex: selectedColor,
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
                      colorIndex: selectedColor,
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
  final int colorIndex;

  CreateNoteScreenArguments(
      {this.title = '',
      this.description = '',
      this.noteId,
      this.colorIndex = 0});
}
