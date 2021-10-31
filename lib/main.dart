import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_note_screen.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/edit_note_screen.dart';

import 'models/note.dart';

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
      },
      //For named routes with parameters.
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == EditNoteScreen.id) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as EditNoteScreenArguments;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return EditNoteScreen(note: args.note);
            },
          );
        }
        if (settings.name == CreateNoteScreen.id) {
          final args = settings.arguments as CreateNoteScreenArguments;

          return MaterialPageRoute(
            builder: (context) {
              return CreateNoteScreen(
                  title: args.title,
                  description: args.description,
                  noteId: args.noteId);
            },
          );
        }
        // The code only supports
        // PassArgumentsScreen.routeName right now.
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
