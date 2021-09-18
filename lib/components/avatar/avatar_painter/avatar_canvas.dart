import 'dart:io';

import 'package:drawme/models/canvas.dart';
import 'package:flutter/material.dart';

class AvatarCanvas extends StatelessWidget {
  final Map<LayerNames, String> layers;
  final double size;

  const AvatarCanvas({
    Key? key,
    required this.layers,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: layers.entries.map((entry) {
        return SizedBox(
          height: size,
          width: size,
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
