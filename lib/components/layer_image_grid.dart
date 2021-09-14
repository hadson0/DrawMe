import 'dart:io';

import 'package:flutter/material.dart';

class LayerImageGrid extends StatelessWidget {
  final void Function(String) onSelectLayerImage;
  final List<String> layerImageList;

  const LayerImageGrid({
    Key? key,
    required this.onSelectLayerImage,
    required this.layerImageList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      color: Colors.grey.shade400,
      child: GridView.builder(
        itemCount: layerImageList.length,
        itemBuilder: (ctx, i) {
          return GestureDetector(
            onTap: () => onSelectLayerImage(layerImageList[i]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                child: layerImageList[i] == ''
                    ? FittedBox(
                        child: Text('X'),
                        fit: BoxFit.contain,
                      )
                    : Image.file(
                        File(layerImageList[i]),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
}
