import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/custom_progress_indicator.dart';

import 'package:notes_app/components/note_card.dart';
import 'package:notes_app/components/notes_staggered_grid_view.dart';
import 'package:notes_app/components/round_icon_border.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/screens/create_note_screen.dart';
import 'package:notes_app/utils/widget_functions.dart';

import 'note_view_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];
  bool isLoading = false;
  NotesDatabase db = NotesDatabase.instance;

  Future getNotesFromDB() async {
    setState(() => isLoading = true);
    // await Future.delayed(const Duration(seconds: 3), () {});
    notes = await db.readAll();
    setState(() => isLoading = false);
    print(notes);
  }

  @override
  void initState() {
    super.initState();
    getNotesFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Notes",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  RoundIconBorder(icon: Icons.search),
                ],
              ),
              getVerticalSpace(15),
              Expanded(
                child: Stack(
                  children: [
                    NotesStaggeredGridView(notesList: notes),
                    isLoading
                        ? CustomProgressIndicator(
                            textMsg: "Loading Notes ...",
                          )
                        : const SizedBox(height: 0, width: 0), //Dummy widget.
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  final note = await db.insertNote(
                    Note(
                      title: "Zlatan ibrahimovic",
                      description: "Manchester United",
                      createdTime: DateTime.now(),
                    ),
                  );
                  print(note.id);

                  getNotesFromDB();
                },
                child: Text("Click me"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateNoteScreen.id);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
