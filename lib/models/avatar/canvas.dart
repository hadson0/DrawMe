import 'package:drawme/models/avatar/layers/layer_items.dart';
import 'package:flutter/widgets.dart';

class Canvas {
  final Map<LayerNames, List<List<String>>> _layers = {
    LayerNames.background: [[]],
  };
  final Map<LayerNames, List<Color>> _colors = {};

  Map<LayerNames, List<List<String>>> get layers => {..._layers};
  Map<LayerNames, List<Color>> get colors => {..._colors};

  void addLayer(LayerNames layerName, int colorNumber) {
    if (!_layers.containsKey(layerName)) {
      _layers[layerName] = List.generate(colorNumber, (index) => []);
      _colors[layerName] = [];
    }
  }

  void removeLayer(LayerNames layerName) {
    if (_layers.containsKey(layerName)) {
      _layers.remove(layerName);
      _colors.remove(layerName);
    }
  }

  void addLayerImage(LayerNames layerName, int colorIndex, String imagePath) {
    if (_layers.containsKey(layerName) &&
        !(_layers[layerName]?[colorIndex].contains(imagePath) ?? false)) {
      _layers[layerName]?[colorIndex].add(imagePath);
    }
  }

  void removeLayerImage(
    LayerNames layerName,
    int colorIndex,
    int imageIndex,
  ) {
    if (_layers.containsKey(layerName)) {
      _layers[layerName]![colorIndex].removeAt(imageIndex);
    }
  }

  void addColorLayer(LayerNames layerName, int colorNumber) {
    if (!_colors.containsKey(layerName)) {
      _colors[layerName] = [];
    }
  }

  void removeColorLayer(LayerNames layerName) {
    if (_colors.containsKey(layerName)) {
      _colors.remove(layerName);
    }
  }

  void addColor(LayerNames layerName, Color color, int colorIndex) {
    if (_colors.containsKey(layerName)) {
      if (colorIndex > _colors[layerName]!.length - 1) {
        _colors[layerName]!.add(color);
      } else {
        _colors[layerName]![colorIndex] = color;
      }
    }
  }

  void removeColor(LayerNames layerName, int colorIndex) {
    if (_colors.containsKey(layerName)) {
      _colors[layerName]?.removeAt(colorIndex);
    }
  }
}
