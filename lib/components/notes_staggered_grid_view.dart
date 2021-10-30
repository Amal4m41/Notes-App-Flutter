import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/models/note.dart';
import 'note_card.dart';

class NotesStaggeredGridView extends StatelessWidget {
  final List<Note> notesList;

  NotesStaggeredGridView({required this.notesList});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      itemCount: notesList.length,
      itemBuilder: (BuildContext context, int index) => NoteCard(
          title: notesList[index].title,
          color: Colors.redAccent.shade100,
          createdDate: "November 2021"),
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
    );
  }
}
