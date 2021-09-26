import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    required this.onColorChanged,
    required this.color,
    Key? key,
  }) : super(key: key);

  final Function(Color) onColorChanged;
  final Color color;

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  Function(Color) get onColorChanged => widget.onColorChanged;
  Color get color => widget.color;

  bool useblackShadow(Color color, {double bias = 1.0}) {
    final int v = sqrt(
      pow(color.red, 2) * 0.299 +
          pow(color.green, 2) * 0.587 +
          pow(color.blue, 2) * 0.114,
    ).round();

    if (v < 130 * bias) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => buildColorPicker(color),
      ),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: (useblackShadow(color, bias: 1.6) ? Colors.grey : color)
                  .withOpacity(0.8),
              offset: const Offset(1.0, 2.0),
              blurRadius: 3.0,
            ),
          ],
        ),
      ),
    );
  }
  Widget buildColorPicker(
    Color color,
  ) => AlertDialog(
      title: const Text('Selecionar cor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlidePicker(
            enableAlpha: false,
            showLabel: false,
            pickerColor: color,
            onColorChanged: onColorChanged,
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
