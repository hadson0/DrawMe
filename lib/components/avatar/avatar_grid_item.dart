import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawme/components/avatar/avatar_detail/avatar_detail_sheet.dart';
import 'package:drawme/models/avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarGridItem extends StatelessWidget {
  const AvatarGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Avatar avatar = Provider.of(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: SizedBox(
          height: 40,
          child: GridTileBar(
            title: AutoSizeText(
              avatar.name,
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'RobotoCondensed',
              ),
            ),
            subtitle: AutoSizeText(
              avatar.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'RobotoCondensed',
                color: Colors.blue,
                fontSize: 10,
              ),
            ),
            backgroundColor: Colors.black87,
            leading: Consumer<Avatar>(
              builder: (BuildContext ctx, Avatar avt, _) => IconButton(
                onPressed: () {
                  avt.toggleFavorite();
                },
                icon: Icon(
                  avt.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        child: GestureDetector(
          child: Image.file(
            File(avatar.avatarSample),
            fit: BoxFit.cover,
          ),
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => AvatarDetailSheet(avatar),
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            enableDrag: false,
            isDismissible: false,
          ),
        ),
      ),
    );
  }
}
