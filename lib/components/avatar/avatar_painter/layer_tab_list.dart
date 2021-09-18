import 'package:flutter/material.dart';

import 'package:drawme/models/canvas.dart';

class LayerTabList extends StatelessWidget {
  final void Function(LayerNames) onSelectLayer;
  final VoidCallback onRandomSelected;

  final Map<LayerNames, List<String>> layersMap;
  final LayerNames selectedLayer;

  const LayerTabList({
    Key? key,
    required this.onSelectLayer,
    required this.onRandomSelected,
    required this.layersMap,
    required this.selectedLayer,
  }) : super(key: key);

  List<Widget> _buildTabList() {
    return layersMap.entries.map((entry) {
      return GestureDetector(
        onTap: () => onSelectLayer(entry.key),
        child: Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            entry.key.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onRandomSelected,
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'RANDOM',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ..._buildTabList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
