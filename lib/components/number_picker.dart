import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  const NumberPicker({
    Key? key,
    required this.initialValue,
    required this.maxValue,
    required this.minValue,
    required this.onValue,
  }) : super(key: key);

  final int initialValue;
  final int maxValue;
  final int minValue;
  final Function(int) onValue;

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  int number = 0;

  @override
  void initState() {
    super.initState();
    number = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              setState(() => number--);
              widget.onValue(number);
            },
            icon: const Icon(Icons.remove),
          ),
          Text('$number'),
          IconButton(
            onPressed: () {
              setState(() => number++);
              widget.onValue(number);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
/* 
initialValue: 1,
        maxValue: 5,
        minValue: 0,
        step: 1,
        onValue: (int value) {
          setState(() => _layers[layerName] = value);
          print(_layers[layerName]);
        },
   */
