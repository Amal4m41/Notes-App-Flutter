import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notes_app/utils/constants.dart';

typedef onChangedColorCallback = void Function(Color value);

class NoteColorPicker extends StatelessWidget {
  final Color selectedColor;
  final onChangedColorCallback callback;

  NoteColorPicker({required this.selectedColor, required this.callback});

  @override
  Widget build(BuildContext context) {
    return BlockPicker(
      availableColors: noteColors,
      pickerColor: selectedColor,
      onColorChanged: callback,
    );
  }
}
