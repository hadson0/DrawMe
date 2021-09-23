import 'package:drawme/models/avatar/layers/layer_items.dart';

class LayerItem {
  const LayerItem({
    required this.title,
    required this.layerName,
  });

  final String title;
  final LayerNames layerName;
}
