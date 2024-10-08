import 'package:drawme/components/avatar/overview/avatar_grid_item.dart';
import 'package:drawme/models/avatar/avatar.dart';
import 'package:drawme/models/avatar/avatar_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarGridScreen extends StatelessWidget {
  const AvatarGridScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AvatarList provider = Provider.of(context);
    final List<Avatar> avatars = provider.avatars;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GridView.builder(
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          itemCount: avatars.length,
          itemBuilder: (BuildContext ctx, int i) =>
              ChangeNotifierProvider.value(
            value: avatars[i],
            child: const AvatarGridItem(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 400 ? 4 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        );
      },
    );
  }
}
