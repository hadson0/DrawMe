import 'package:flutter/material.dart';

class AvatarCanvas extends StatelessWidget {
  final List<String> layers;

  const AvatarCanvas(
    this.layers, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: layers.map((layer) {
        return Container(
          child: Image.asset(
            layer,
            fit: BoxFit.contain,
          ),
        );
      }).toList(),
    );
  }
}
