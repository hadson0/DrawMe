import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:drawme/components/avatar/avatar_grid_item.dart';

import 'package:drawme/models/avatar.dart';
import 'package:drawme/models/avatar_list.dart';

class AvatarGridScreen extends StatelessWidget {
  AvatarGridScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AvatarList>(context);
    final List<Avatar> avatars = provider.avatars;

    return Scrollbar(
      isAlwaysShown: true,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: avatars.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: avatars[i],
          child: AvatarGridItem(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
