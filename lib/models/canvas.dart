import 'package:flutter/widgets.dart';

enum LayerNames { BACKGROUND, BODY, EYES, NOSE, MOUTH }

class Canvas with ChangeNotifier {
  final Map<LayerNames, List<List<String>>> _layers = {};

  Map<LayerNames, List<List<String>>> get layers => {..._layers};

  void addLayer(LayerNames layerName) {
    if (!_layers.containsKey(layerName)) {
      _layers[layerName] = [];
      notifyListeners();
    }
  }

  void removeLayer(LayerNames layerName) {
    if (_layers.containsKey(layerName)) {
      _layers.remove(layerName);
      notifyListeners();
    }
  }

  void removeEmptyLayers() {
    _layers.removeWhere(
      (LayerNames layer, List<List<String>> imageList) => imageList.isEmpty || (imageList.length == 1 && imageList[0] == ''),
    );
  }

  void addLayerImage(LayerNames layerName, int colorIndex, String imagePath) {
    if (_layers.containsKey(layerName)) {
      _layers[layerName]?[colorIndex].add(imagePath);
      notifyListeners();
    }
  }

  void removeLayerImage(LayerNames layerName, int colorIndex, String imagePath) {
    if (_layers.containsKey(layerName)) {
      final int index =
          _layers[layerName]![colorIndex].indexWhere((String imageP) => imageP == imagePath);

      if (index >= 0) {
        _layers[layerName]![colorIndex].removeWhere((String imageP) => imageP == imagePath);
        notifyListeners();
      }
    }
  }
}
