import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/custom_progress_indicator.dart';

import 'package:notes_app/components/note_card.dart';
import 'package:notes_app/components/notes_empty_message.dart';
import 'package:notes_app/components/notes_staggered_grid_view.dart';
import 'package:notes_app/components/round_icon_border.dart';
import 'package:notes_app/components/search_box.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/screens/create_note_screen.dart';
import 'package:notes_app/utils/constants.dart';
import 'package:notes_app/utils/widget_functions.dart';

import 'view_note_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];
  List<Note> searchedNotes = [];
  bool isLoading = false;
  bool isSearching = false;
  NotesDatabase db = NotesDatabase.instance;

  Future getNotesFromDB() async {
    setState(() => isLoading = true);
    // await Future.delayed(const Duration(seconds: 3), () {});
    notes = await db.readAll();
    print(notes.map((e) => e.id).toList());
    //Passing list value instead of reference, basically creating a new copy of the list.
    searchedNotes = notes.toList();
    isSearching = false;
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getNotesFromDB();
  }

  @override
  Widget build(BuildContext context) {
    // print("HOME SCREEN");
    return Scaffold(
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.all(10).copyWith(bottom: 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Notes",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSearching = !isSearching;
                          //When the search option is switched off, display the entire notes list.
                          !isSearching ? searchedNotes = notes.toList() : null;
                        });
                      },
                      child: RoundIconBorder(
                          icon: isSearching ? Icons.search_off : Icons.search),
                    ),
                  ],
                ),
              ),
              getVerticalSpace(10),
              isSearching
                  ? SearchBox(
                      callback: (String searchText) {
                        print(searchText);
                        // print(notes);
                        searchForNotes(searchText);
                      },
                    )
                  : const SizedBox(height: 0, width: 0),
              Expanded(
                child: notes.isEmpty
                    ? NotesEmptyMessage()
                    : Stack(
                        children: [
                          NotesStaggeredGridView(
                            notesList: searchedNotes,
                            onTapNoteItem: (int itemIndex) async {
                              Note selectedNote = searchedNotes[itemIndex];

                              DbNoteAction? result = await Navigator.pushNamed(
                                      context, ViewNoteScreen.id,
                                      arguments: ViewNoteScreenArguments(
                                          note: searchedNotes[itemIndex]))
                                  as DbNoteAction?;

                              if (result == DbNoteAction.delete) {
                                getNotesFromDB();
                                showSnackBarWithAction(
                                  context: context,
                                  message: "You deleted a note!",
                                  onPressed: () async {
                                    // print("Deleted  : ${selectedNote.id}");
                                    await NotesDatabase.instance
                                        .insertNote(selectedNote);
                                    getNotesFromDB();
                                  },
                                );
                              } else if (result == DbNoteAction.update) {
                                getNotesFromDB();
                              }
                            },
                          ),
                          isLoading
                              ? CustomProgressIndicator(
                                  textMsg: "Loading Notes ...",
                                )
                              : const SizedBox(
                                  height: 0, width: 0), //Dummy widget.
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade700,
        onPressed: () async {
          //If we user just presses the back button, the screen will popped returning a null
          DbNoteAction? result = await Navigator.pushNamed(
              context, CreateNoteScreen.id,
              arguments: CreateNoteScreenArguments()) as DbNoteAction?;
          if (result == DbNoteAction.insert) {
            getNotesFromDB();
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }

  void searchForNotes(String noteName) {
    List<Note> result = notes
        .where(
            (note) => note.title.toLowerCase().contains(noteName.toLowerCase()))
        .toList();
    setState(() {
      searchedNotes = result;
      print("notes : $notes");
      print(searchedNotes);
    });
  }
}
