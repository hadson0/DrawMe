import 'dart:io';

import 'package:drawme/models/canvas.dart';
import 'package:flutter/material.dart';

class AvatarCanvas extends StatelessWidget {
  final Map<LayerNames, String> layers;

  const AvatarCanvas(
    this.layers, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: layers.entries.map((entry) {
        return SizedBox(
          height: screenWidth,
          width: screenWidth,
          child: entry.value == ''
              ? null
              : Image.file(
                  File(entry.value),
                  fit: BoxFit.contain,
                ),
        );
      }).toList(),
    );
  }
}
