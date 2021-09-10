import 'package:flutter/widgets.dart';

class Avatar with ChangeNotifier {
  final String id;
  final String name;
  final String author;
  final String avatarSample;
  final List<String> tags;
  final String description;
  bool isFavorite;

  Avatar({
    required this.id,
    required this.name,
    required this.author,
    required this.imagePath,
    required this.tags,
    required this.description,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
