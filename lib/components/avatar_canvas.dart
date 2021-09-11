import 'package:flutter/material.dart';

class AvatarCanvas extends StatelessWidget {
  final Map<String, String> layers;

  const AvatarCanvas(
    this.layers, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: layers.entries.map((entry) {
        return Container(
          child: Image.asset(
            entry.value,
            fit: BoxFit.contain,
          ),
        );
      }).toList(),
    );
  }
}
