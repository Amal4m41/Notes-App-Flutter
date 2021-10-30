import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/models/note.dart';
import 'note_card.dart';
import 'package:notes_app/screens/edit_note_screen.dart';

class NotesStaggeredGridView extends StatelessWidget {
  final List<Note> notesList;

  NotesStaggeredGridView({required this.notesList});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      itemCount: notesList.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () {
          Navigator.pushNamed(context, EditNoteScreen.id,
              arguments: EditNoteScreenArguments(note: notesList[index]));
        },
        child: NoteCard(
            title: notesList[index].title,
            color: Colors.redAccent.shade100,
            createdDate: "November 2021"),
      ),
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
    );
  }
}
