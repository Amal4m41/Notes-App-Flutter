import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/components/note_card.dart';
import 'package:notes_app/components/round_icon_card.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/models/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];
  List<Note> notesTemp = [];
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
                  RoundIconCard(icon: Icons.search),
                ],
              ),
              Expanded(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) => NoteCard(
                      title: notes[index].title,
                      color: Colors.redAccent.shade200,
                      createdDate: "November 2021"),
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(2, index.isEven ? 2 : 1),
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                ),
              ),
              // TextButton(
              //   onPressed: () async {
              //     final note = await db.insertNote(
              //       Note(
              //         title: "Ronaldo teams",
              //         description: "Manchester United",
              //         createdTime: DateTime.now(),
              //       ),
              //     );
              //     print(note.id);
              //   },
              //   child: Text("Click me"),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
