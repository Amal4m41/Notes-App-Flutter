import 'package:flutter/material.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/models/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];
  NotesDatabase db = NotesDatabase.instance;

  Future getNotesFromDB() async {
    notes = await db.readAll();
    print(notes);
  }

  @override
  void initState() {
    super.initState();
    getNotesFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          onPressed: () async {
            final note = await db.insertNote(
              Note(
                title: "Ronaldo teams",
                description: "Manchester United",
                createdTime: DateTime.now(),
              ),
            );
            print(note.id);
          },
          child: Text("Click me"),
        ),
      ),
    );
  }
}
