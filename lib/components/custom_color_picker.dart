import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    Key? key,
    required this.onColorChanged,
    required this.color,
  }) : super(key: key);

  final Function(Color) onColorChanged;
  final Color color;

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecionar cor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlidePicker(
            enableAlpha: false,
            showLabel: false,
            pickerColor: widget.color,
            onColorChanged: widget.onColorChanged,
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'SELECIONAR',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
