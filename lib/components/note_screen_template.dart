import 'package:flutter/material.dart';
import 'package:notes_app/utils/widget_functions.dart';

typedef onChangedTextCallback = void Function(String value);

class NoteScreenTemplate extends StatelessWidget {
  final Row toolbar;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final bool editable;

  NoteScreenTemplate({
    required this.titleController,
    required this.descriptionController,
    required this.toolbar,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              toolbar,
              TextField(
                controller: titleController,
                enabled: editable,
                // onChanged: onChangedTitleText,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey)),
                  // enabledBorder:
                  //     UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              getVerticalSpace(5),
              Container(
                // color: Colors.greenAccent,
                //Get the height of the screen - height that'll be occupied by the keyboard when it's active - 160.
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom -
                    165,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey, width: 0.09),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: descriptionController,
                    enabled: editable,
                    // onChanged: onChangedDescriptionText,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType
                        .multiline, //maxlines = true is needed for this to work
                    maxLines: null, //no limit on the number of lines.
                    decoration: const InputDecoration(
                      hintText: "Type note here.. ✍",
                      hintStyle: TextStyle(fontSize: 16),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      // focusedBorder:
                      //     UnderlineInputBorder(borderSide: BorderSide.none),
                      // enabledBorder:
                      //     UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
