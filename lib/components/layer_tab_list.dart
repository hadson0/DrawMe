import 'package:flutter/material.dart';

import 'package:drawme/models/canvas.dart';

class   LayerTabList extends StatelessWidget {
  final void Function(LayerNames) onSelectLayer;
  final Map<LayerNames, List<String>> layersMap;
  final LayerNames selectedLayer;

  const LayerTabList({
    Key? key,
    required this.onSelectLayer,
    required this.layersMap,
    required this.selectedLayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.black),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: layersMap.entries.map((entry) {
            return GestureDetector(
              onTap: () => onSelectLayer(entry.key),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade800,
                    width: 2,
                  ),
                ),
                child: Text(
                  entry.key.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
