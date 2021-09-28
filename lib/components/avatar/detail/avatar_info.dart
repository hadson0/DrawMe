import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawme/components/avatar/detail/avatar_tag_bar.dart';
import 'package:drawme/models/avatar/avatar.dart';
import 'package:flutter/material.dart';

class AvatarInfo extends StatelessWidget {
  const AvatarInfo(
    this.avatar, {
    Key? key,
  }) : super(key: key);

  final Avatar avatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black87,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                avatar.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white,
                    ),
              ),
              AutoSizeText(
                avatar.author,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
        AvatarTagBar(avatar),
        Container(
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Descrição:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: SelectableText(
                  avatar.description,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
