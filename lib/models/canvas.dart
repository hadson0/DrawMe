import 'package:flutter/widgets.dart';

class Canvas with ChangeNotifier {
  final Map<int, List<String>> _layers = {
    0: ['lib/assets/images/Man/background.png'],
    1: ['lib/assets/images/Man/body.png'],
    2: [
      '',
      'lib/assets/images/Man/eyes.png',
      'lib/assets/images/Man/eyes2.png'
    ],
    3: [
      '',
      'lib/assets/images/Man/nose.png',
      'lib/assets/images/Man/nose2.png'
    ],
    4: [
      '',
      'lib/assets/images/Man/mouth.png',
      'lib/assets/images/Man/mouth2.png'
    ],
  };

  Map<int, List<String>> get layers => {..._layers};

  void addLayerImage(String layerName, String imagePath) {
    if (layers.containsKey(layerName)) {
      layers[layerName]?.add(imagePath);
      notifyListeners();
    }
  }

  void removeLayerImage(String layerName, String imagePath) {
    if (layers.containsKey(layerName)) {
      int index =
          layers[layerName]!.indexWhere((imageP) => imageP == imagePath);

      if (index >= 0) {
        layers[layerName]!.removeWhere((imageP) => imageP == imagePath);
        notifyListeners();
      }
    }
  }
}
