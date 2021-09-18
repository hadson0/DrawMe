import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:drawme/components/avatar/avatar_grid_item.dart';

import 'package:drawme/models/avatar.dart';
import 'package:drawme/models/avatar_list.dart';

class AvatarGridScreen extends StatelessWidget {
  const AvatarGridScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AvatarList>(context);
    final List<Avatar> avatars = provider.avatars;

    return LayoutBuilder(builder: (context, constraints) {
      return Scrollbar(
        isAlwaysShown: true,
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: avatars.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: avatars[i],
            child: const AvatarGridItem(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 400 ? 4 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      );
    },);
  }
}
