import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_note_screen.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/note_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        CreateNoteScreen.id: (context) => CreateNoteScreen(),
        NoteViewScreen.id: (context) => NoteViewScreen(),
      },
    );
  }
}
