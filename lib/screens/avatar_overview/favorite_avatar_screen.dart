import 'package:drawme/components/avatar/avatar_grid_item.dart';
import 'package:drawme/models/avatar/avatar.dart';
import 'package:drawme/models/avatar/avatar_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteAvatarScreen extends StatelessWidget {
  const FavoriteAvatarScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AvatarList>(context);
    final List<Avatar> favoriteAvatars = provider.favoriteAvatars;

    if (favoriteAvatars.isEmpty) {
      return const Center(
        child: Text('Nenhum avatar foi marcado como favorito!'),
      );
    } else {
      return Scrollbar(
        isAlwaysShown: true,
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: favoriteAvatars.length,
          itemBuilder: (BuildContext ctx, int i) =>
              ChangeNotifierProvider.value(
            value: favoriteAvatars[i],
            child: const AvatarGridItem(),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      );
    }
  }
}
