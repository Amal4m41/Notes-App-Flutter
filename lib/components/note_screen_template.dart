import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notes_app/components/note_color_picker.dart';
import 'package:notes_app/utils/widget_functions.dart';

typedef onChangedTextCallback = void Function(String value);

class NoteScreenTemplate extends StatelessWidget {
  final Row toolbar;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final bool editable;
  final Color selectedColor;
  final onChangedColorCallback callback;

  NoteScreenTemplate({
    required this.titleController,
    required this.descriptionController,
    required this.toolbar,
    this.editable = true,
    required this.selectedColor,
    required this.callback,
  });

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(vertical: 230, horizontal: 50),
        title: const Text("Pick Note Color"),
        content:
            NoteColorPicker(selectedColor: selectedColor, callback: callback),
      ),
    );
  }

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
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      enabled: editable,
                      // onChanged: onChangedTitleText,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        // hintText: "Title",
                        labelText: "Title",
                        // floatingLabelStyle: TextStyle(color: Colors.blueGrey),
                        labelStyle: TextStyle(
                            textBaseline: TextBaseline.ideographic,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        // enabledBorder:
                        //     UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  editable
                      ? InkWell(
                          onTap: () {
                            pickColor(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: selectedColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                ],
              ),
              getVerticalSpace(5),
              Container(
                // color: Colors.greenAccent,
                //Get the height of the screen - height that'll be occupied by the keyboard when it's active - 160.
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom -
                    170,
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
