import 'package:flutter/widgets.dart';

class Avatar with ChangeNotifier {
  final String id;
  final String name;
  final String author;
  final String avatarSample;
  final List<String> tags;
  final String description;

  final Map<String, List<String>> layers = {
    'background': ['lib/assets/images/Man/background.png'],
    'body': ['lib/assets/images/Man/body.png'],
    'eyes': [
      'lib/assets/images/Man/eyes.png',
      'lib/assets/images/Man/eyes2.png'
    ],
    'nose': [
      'lib/assets/images/Man/nose.png',
      'lib/assets/images/Man/nose2.png'
    ],
    'mouth': [
      'lib/assets/images/Man/mouth.png',
      'lib/assets/images/Man/mouth2.png'
    ],
  };

  /* final Map<String, List<String>> layers = {
    'background': [''],
    'body': [''],
    'eyes': [''],
    'nose': [''],
    'mouth': [''],
  }; */

  bool isFavorite;

  Avatar({
    required this.id,
    required this.name,
    required this.author,
    required this.avatarSample,
    required this.tags,
    required this.description,
    this.isFavorite = false,
  });

  void addLayerImage(String layerName, String imagePath) {
    if (layers.containsKey(layerName)) {
      layers[layerName]?.add(imagePath);
      /* notifyListeners(); */
    }
  }

  void removeLayerImage(String layerName, String imagePath) {
    if (layers.containsKey(layerName)) {
      int index = layers[layerName]!.indexWhere((imageP) => imageP == imagePath);

      if (index >= 0) {
        layers[layerName]!.removeWhere((imageP) => imageP == imagePath);
        notifyListeners();
      }
    }
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
