import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:drawme/components/avatar_grid_item.dart';

import 'package:drawme/models/avatar.dart';
import 'package:drawme/models/avatar_list.dart';

class FavoriteAvatarScreen extends StatelessWidget {
  FavoriteAvatarScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AvatarList>(context);
    final List<Avatar> favoriteAvatars = provider.favoriteAvatars;

    if (favoriteAvatars.isEmpty) {
      return Center(
        child: Text('Nenhum avatar foi marcado como favorito!'),
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: favoriteAvatars.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: favoriteAvatars[i],
          child: AvatarGridItem(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      );
    }
  }
}
