import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:notes_app/components/capsule_text_border.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              TextField(
                onChanged: (String titleValue) {
                  title = titleValue;
                },
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey)),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none)),
              ),
              getVerticalSpace(5),
              Container(
                // color: Colors.greenAccent,
                //Get the height of the screen - height that'll be occupied by the keyboard when it's active - 160.
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom -
                    165,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey, width: 0.09),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: TextField(
                    onChanged: (String descriptionValue) {
                      description = descriptionValue;
                    },
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType
                        .multiline, //maxlines = true is needed for this to work
                    maxLines: null, //no limit on the number of lines.
                    decoration: const InputDecoration(
                        hintText: "Type note here.. ✍",
                        hintStyle: TextStyle(fontSize: 16),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
