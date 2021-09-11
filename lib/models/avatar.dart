import 'package:drawme/models/canvas.dart';
import 'package:flutter/widgets.dart';

class Avatar with ChangeNotifier {
  final String id;
  final String name;
  final String author;
  final String avatarSample;
  final List<String> tags;
  final String description;

  Canvas canvas = Canvas();

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
    if (canvas.layers.containsKey(layerName)) {
      canvas.layers[layerName]?.add(imagePath);
      /* notifyListeners(); */
    }
  }

  void removeLayerImage(String layerName, String imagePath) {
    if (canvas.layers.containsKey(layerName)) {
      int index =
          canvas.layers[layerName]!.indexWhere((imageP) => imageP == imagePath);

      if (index >= 0) {
        canvas.layers[layerName]!.removeWhere((imageP) => imageP == imagePath);
        notifyListeners();
      }
    }
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
