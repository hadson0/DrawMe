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
      color: Colors.grey.shade400,
      child: GridView.builder(
        itemCount: layerImageList.length,
        itemBuilder: (ctx, i) {
          return GestureDetector(
            onTap: () => onSelectLayerImage(layerImageList[i]),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: layerImageList[i] == ''
                  ? FittedBox(
                      child: Text('X'),
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      layerImageList[i],
                      fit: BoxFit.cover,
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
