import 'package:flutter/widgets.dart';

class Avatar with ChangeNotifier {
  final String id;
  final String name;
  final String author;
  final String avatarSample;
  final List<String> tags;
  final String description;

  final Map<String, List<String>> layers = {
    'background': [''],
    'body': [''],
    'eyes': [''],
    'nose': [''],
    'mouth': [''],
  };

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

  void addLayerImage(String layerName, String image) {
    if (layers.containsKey(layerName)) {
      layers[layerName]?.add(image);
      notifyListeners();
    }
  }

  void removeLayerImage(String layerName, String image) {
    if (layers.containsKey(layerName)) {
      int index = layers[layerName]!.indexWhere((img) => img == image);

      if (index >= 0) {
        layers[layerName]!.removeWhere((img) => img == image);
        notifyListeners();
      }
    }
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
