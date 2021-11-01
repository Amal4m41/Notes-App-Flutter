import 'package:flutter/material.dart';
import 'package:notes_app/components/note_screen_template.dart';

class SearchBox extends StatefulWidget {
  final onChangedTextCallback callback;
  SearchBox({required this.callback});

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //so that all notes appear when user clicks the search button, since '' is contained by all strings.
    searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    // print("SEARCH BOX SCREEN");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        autofocus: true,
        controller: searchController,
        onChanged: (_) {
          // print(searchController.text);
          widget.callback(searchController.text);
          //No need to call setState() here, cuz the parent widget call setState after the above callback. Since the parent widget
          //is rebuilt, SearchBox being it's child widget is rebuilt too.
          // setState(() {});
        },
        decoration: InputDecoration(
          suffixIcon: searchController.text.isEmpty
              ? null
              : InkWell(
                  onTap: () {
                    searchController.clear();
                    widget.callback(
                        ''); //so that all list notes will be displayed.
                  },
                  child: Icon(Icons.clear),
                ),
          border: OutlineInputBorder(),
          hintText: "Search for notes",
        ),
      ),
    );
  }
}
