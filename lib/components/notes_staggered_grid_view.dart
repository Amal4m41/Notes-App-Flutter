import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/utils/constants.dart';
import 'note_card.dart';
import 'package:notes_app/screens/edit_note_screen.dart';

typedef onTapNoteItemCallback = void Function(int itemIndex);

class NotesStaggeredGridView extends StatelessWidget {
  final List<Note> notesList;
  final onTapNoteItemCallback onTapNoteItem;

  NotesStaggeredGridView(
      {required this.notesList, required this.onTapNoteItem});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      itemCount: notesList.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () {
          onTapNoteItem(index);
        },
        child: NoteCard(
            title: notesList[index].title,
            color: noteColors[notesList[index].colorIndex],
            createdDate:
                DateFormat.yMMMd().format(notesList[index].createdTime)),
      ),
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
    );
  }
}
