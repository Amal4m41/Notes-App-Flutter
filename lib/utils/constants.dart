import 'package:flutter/cupertino.dart';

const String kDatabaseName = "notes.db";
const String kNotesTableName = "notes";

//For identifying the operations done on the database while returning from a screen.
enum DbNoteAction {
  insert, //C
  read, //R
  update, //U
  delete, //D
}

List<Color> noteColors = const [
  Color(0xffef9a9a),
  Color(0xfff06292),
  Color(0xffcddc39),
  Color(0xfffdd835),
  Color(0xffffa726),
  Color(0xff607d8b),
  Color(0xffbdbdbd),
  Color(0xff64ffda),
  Color(0xff18ffff),
  Color(0xff5c6bc0),
  Color(0xff9575cd),
  Color(0xffd500f9),
];
