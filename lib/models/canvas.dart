import 'package:flutter/widgets.dart';

enum LayerNames { BACKGROUND, BODY, EYES, NOSE, MOUTH }

class Canvas with ChangeNotifier {
  final Map<LayerNames, List<String>> _layers = {};

  Map<LayerNames, List<String>> get layers => {..._layers};

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
      (key, value) => value.isEmpty || (value.length == 1 && value[0] == ''),
    );
  }

  void addLayerImage(LayerNames layerName, String imagePath) {
    if (_layers.containsKey(layerName)) {
      _layers[layerName]?.add(imagePath);
      notifyListeners();
    }
  }

  void removeLayerImage(LayerNames layerName, String imagePath) {
    if (_layers.containsKey(layerName)) {
      final int index =
          _layers[layerName]!.indexWhere((imageP) => imageP == imagePath);

      if (index >= 0) {
        _layers[layerName]!.removeWhere((imageP) => imageP == imagePath);
        notifyListeners();
      }
    }
  }
}
