import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorBlockPicker extends StatefulWidget {
  const CustomColorBlockPicker({
    Key? key,
    required this.onColorChanged,
    required this.selectedColor,
    required this.colorList,
  }) : super(key: key);

  final Function(Color) onColorChanged;
  final List<Color> colorList;
  final Color selectedColor;

  @override
  _CustomColorBlockPickerState createState() => _CustomColorBlockPickerState();
}

class _CustomColorBlockPickerState extends State<CustomColorBlockPicker> {
  Function(Color) get onColorChanged => widget.onColorChanged;
  List<Color> get colorList => widget.colorList;
  Color get selectedColor => widget.selectedColor;

  Widget _itemBuilder(
    Color color,
    bool isCurrentColor,
    void Function() changeColor,
  ) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: (useWhiteForeground(color) ? color : Colors.black)
                .withOpacity(0.8),
            offset: const Offset(1.0, 2.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(50.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: Icon(
              Icons.done,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecionar cor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlockPicker(
            pickerColor: selectedColor,
            onColorChanged: onColorChanged,
            availableColors: colorList,
            itemBuilder: _itemBuilder,
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
