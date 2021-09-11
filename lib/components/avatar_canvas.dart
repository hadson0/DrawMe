import 'package:flutter/material.dart';

class AvatarCanvas extends StatelessWidget {
  final Map<int, String> layers;

  const AvatarCanvas(
    this.layers, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: layers.entries.map((entry) {
        return Container(
          child: entry.value == ''
              ? null
              : Image.asset(
                  entry.value,
                  fit: BoxFit.contain,
                ),
        );
      }).toList(),
    );
  }
}
