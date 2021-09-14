import 'dart:io';

import 'package:flutter/material.dart';

import 'package:drawme/models/canvas.dart';

class AvatarCanvas extends StatelessWidget {
  final Map<LayerNames, String> layers;

  const AvatarCanvas({
    Key? key,
    required this.layers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: layers.entries.map((entry) {
        return Container(
          height: 360,
          width: 360,
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
