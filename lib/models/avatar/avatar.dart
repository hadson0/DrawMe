import 'package:drawme/models/avatar/canvas.dart';
import 'package:flutter/widgets.dart';

class Avatar with ChangeNotifier {
  Avatar({
    required this.id,
    required this.name,
    required this.author,
    required this.avatarSample,
    required this.tags,
    required this.description,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final String author;
  final String avatarSample;
  final List<String> tags;
  final String description;

  Canvas avatarCanvas = Canvas();

  Canvas get canvas {
    return avatarCanvas;
  }

  set canvas(Canvas newCanvas) {
    if (newCanvas.layers.isNotEmpty && newCanvas.colors.isNotEmpty) {
      avatarCanvas = newCanvas;
    }
  }

  bool isFavorite;

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
