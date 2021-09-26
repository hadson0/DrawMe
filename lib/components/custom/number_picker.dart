import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  const NumberPicker({
    required this.initialValue,
    required this.maxValue,
    required this.minValue,
    required this.onValue,
    Key? key,
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

  int get initialValue => widget.initialValue;
  int get maxValue => widget.maxValue;
  int get minValue => widget.minValue;
  Function(int) get onValue => widget.onValue;

  @override
  void initState() {
    super.initState();
    number = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              if (number > minValue) {
                setState(() => number--);
                onValue(number);
              }
            },
            icon: const Icon(Icons.remove),
          ),
          Text('$number'),
          IconButton(
            onPressed: () {
              if (number < maxValue) {
                setState(() => number++);
                onValue(number);
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
