import 'package:drawme/models/avatar/layers/layer_items.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LayerTabList extends StatelessWidget {
  const LayerTabList({
    required this.onSelectLayer,
    required this.onRandomSelected,
    required this.layersMap,
    required this.selectedLayer,
    Key? key,
  }) : super(key: key);

  final void Function(LayerNames) onSelectLayer;
  final VoidCallback onRandomSelected;
  final Map<LayerNames, List<List<String>>> layersMap;
  final LayerNames selectedLayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Row(
        // ignore: always_specify_types
        children: [
          GestureDetector(
            onTap: onRandomSelected,
            child: Container(
              height: 64,
              width: 64,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Icon(
                FontAwesomeIcons.sync,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    ...buildTabList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildTabList() => layersMap.entries
      .map(
        (MapEntry<LayerNames, List<List<String>>> imageList) => GestureDetector(
          onTap: () => onSelectLayer(imageList.key),
          child: Container(
            height: 64,
            width: 64,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              imageList.key.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
      .toList();
}
