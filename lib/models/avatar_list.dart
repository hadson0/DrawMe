import 'package:flutter/material.dart';

import 'package:drawme/models/avatar.dart';

class AvatarList with ChangeNotifier {
  List<Avatar> _avatars = [];

  List<Avatar> get avatars => [..._avatars];

  List<Avatar> get favoriteAvatars =>
      _avatars.where((avt) => avt.isFavorite).toList();

  int get avatarsCount {
    return _avatars.length;
  }

  void addAvatar(Avatar avatar) {
    _avatars.add(avatar);
    notifyListeners();
  }

  void removeAvatar(Avatar avatar) {
    int index = _avatars.indexWhere((avt) => avt.id == avatar.id);

    if (index >= 0) {
      _avatars.removeWhere((avt) => avt.id == avatar.id);
      notifyListeners();
    }
  }
}
