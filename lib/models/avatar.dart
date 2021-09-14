import 'package:flutter/widgets.dart';

import 'package:drawme/models/canvas.dart';

class Avatar with ChangeNotifier {
  final String id;
  final String name;
  final String author;
  final String avatarSample;
  final List<String> tags;
  final String description;

  Canvas canvas = Canvas();

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

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
