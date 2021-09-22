import 'package:drawme/models/avatar/avatar.dart';
import 'package:flutter/material.dart';

class AvatarList with ChangeNotifier {
  final List<Avatar> _avatars = [];

  List<Avatar> get avatars => [..._avatars];

  List<Avatar> get favoriteAvatars =>
      _avatars.where((Avatar avt) => avt.isFavorite).toList();

  int get avatarsCount {
    return _avatars.length;
  }

  void addAvatar(Avatar avatar) {
    _avatars.add(avatar);
    notifyListeners();
  }

  void removeAvatar(Avatar avatar) {
    final int index = _avatars.indexWhere((Avatar avt) => avt.id == avatar.id);

    if (index >= 0) {
      _avatars.removeWhere((Avatar avt) => avt.id == avatar.id);
      notifyListeners();
    }
  }
}
