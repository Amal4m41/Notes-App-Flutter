//Data/Model class for note
class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  //Converts the note object to a map/json.
  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.createdTime: createdTime.toIso8601String(),
      };

  //Converts the json/map object to a note object
  static Note fromJson({required Map json}) {
    return Note(
      id: json["_id"] as int?,
      title: json["title"] as String,
      description: json["description"] as String,
      createdTime: DateTime.parse(json["createdTime"] as String),
    );
  }

  //This function is used to create a new Note object with different values if any that are passed as argument to it.
  Note copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        //if there's no passed title, then the value of it will be null, in that case take the current instance
        // existing value (i.e the instance which called this method).
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );
}

//Defining the column/field names for our 'notes' table.
class NoteFields {
  //by default we have '_' before the id in sqlite
  static const String id = "_id";
  static const String title = "title";
  static const String description = "description";
  static const String createdTime = "createdTime";

  static const List<String> columns = [id, title, description, createdTime];
}
