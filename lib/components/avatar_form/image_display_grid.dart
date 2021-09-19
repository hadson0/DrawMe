import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImageDisplayGrid extends StatefulWidget {
  const ImageDisplayGrid({
    Key? key,
    required this.selectedLayer,
    required this.itemCount,
  }) : super(key: key);

  final List<XFile> selectedLayer;
  final int itemCount;

  @override
  State<ImageDisplayGrid> createState() => _ImageDisplayGridState();
}

class _ImageDisplayGridState extends State<ImageDisplayGrid> {
  List<XFile> get selectedLayer => widget.selectedLayer;
  int get itemCount => widget.itemCount;

  ClipRRect _buildImageGridItem({
    required XFile image,
    required VoidCallback onDeletePressed,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget> [
          Image.file(
            File(image.path),
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
            image: selectedLayer[i],
            onDeletePressed: () {
              setState(
                () {
                  selectedLayer.removeAt(i);
                },
              );
            },
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
