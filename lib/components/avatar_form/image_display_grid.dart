import 'dart:io';

import 'package:flutter/material.dart';

class ImageDisplayGrid extends StatefulWidget {
  const ImageDisplayGrid({
    Key? key,
    required this.selectedLayer,
    required this.itemCount,
    required this.onDeletePressed,
  }) : super(key: key);

  final Function(int) onDeletePressed;
  final List<String> selectedLayer;
  final int itemCount;

  @override
  State<ImageDisplayGrid> createState() => _ImageDisplayGridState();
}

class _ImageDisplayGridState extends State<ImageDisplayGrid> {
  List<String> get selectedLayer => widget.selectedLayer;
  int get itemCount => widget.itemCount;

  ClipRRect _buildImageGridItem({
    required String imagePath,
    required VoidCallback onDeletePressed,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(255, 255, 244, 0.5),
              ),
              child: IconButton(
                onPressed: onDeletePressed,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext ctx, int i) {
          return _buildImageGridItem(
            imagePath: selectedLayer[i],
            onDeletePressed: () => widget.onDeletePressed(i),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }
}
