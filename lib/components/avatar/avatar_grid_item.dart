import 'dart:io';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import 'package:drawme/components/avatar/avatar_detail/avatar_detail_sheet.dart';

import 'package:drawme/models/avatar.dart';

class AvatarGridItem extends StatelessWidget {
  const AvatarGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = Provider.of<Avatar>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.file(
            File(avatar.avatarSample),
            fit: BoxFit.cover,
          ),
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) => AvatarDetailSheet(avatar),
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            enableDrag: false,
            isDismissible: false,
          ),
        ),
        footer: Container(
          height: 40,
          child: GridTileBar(
            title: Container(
              child: AutoSizeText(
                avatar.name,
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                ),
              ),
            ),
            subtitle: AutoSizeText(
              avatar.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                color: Colors.blue,
                fontSize: 10,
              ),
            ),
            backgroundColor: Colors.black87,
            leading: Consumer<Avatar>(
              builder: (ctx, avt, _) => IconButton(
                onPressed: () {
                  avt.toggleFavorite();
                },
                icon: Icon(
                    avt.isFavorite ? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
