import 'dart:io';

import 'package:drawme/models/avatar/layers/layer_items.dart';
import 'package:flutter/material.dart';

class AvatarCanvas extends StatelessWidget {
  const AvatarCanvas({
    required this.layers,
    required this.size,
    Key? key,
  }) : super(key: key);

  final Map<LayerNames, String> layers;
  final double size;

  @override
  Widget build(BuildContext context) => Stack(
        children: layers.entries
            .map(
              (MapEntry<LayerNames, String> entry) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: size,
                  width: size,
                  child: entry.value == ''
                      ? null
                      : Image.file(
                          File(entry.value),
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            )
            .toList(),
      );
}
