import 'dart:io';

import 'package:flutter/material.dart';

class LayerImageGrid extends StatelessWidget {
  const LayerImageGrid({
    Key? key,
    required this.onSelectLayerImage,
    required this.layerImageList,
  }) : super(key: key);

  final void Function(String) onSelectLayerImage;
  final List<String> layerImageList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: GridView.builder(
        itemCount: layerImageList.length,
        itemBuilder: (BuildContext ctx, int i) {
          return GestureDetector(
            onTap: () => onSelectLayerImage(layerImageList[i]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                child: layerImageList[i] == ''
                    ? const FittedBox(
                        child: Text('X'),
                      )
                    : Image.file(
                        File(layerImageList[i]),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
}
