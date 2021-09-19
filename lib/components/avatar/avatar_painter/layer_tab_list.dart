import 'package:drawme/models/canvas.dart';
import 'package:flutter/material.dart';

class LayerTabList extends StatelessWidget {
  const LayerTabList({
    Key? key,
    required this.onSelectLayer,
    required this.onRandomSelected,
    required this.layersMap,
    required this.selectedLayer,
  }) : super(key: key);

  final void Function(LayerNames) onSelectLayer;
  final VoidCallback onRandomSelected;

  final Map<LayerNames, List<List<String>>> layersMap;
  final LayerNames selectedLayer;

  List<Widget> _buildTabList() {
    return layersMap.entries
        .map((MapEntry<LayerNames, List<List<String>>> imageList) {
      return GestureDetector(
        onTap: () => onSelectLayer(imageList.key),
        child: Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            imageList.key.toString(),
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
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Row(
        // ignore: always_specify_types
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
              child: const Text(
                'RANDOM',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ..._buildTabList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
