import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:drawme/components/avatar/avatar_detail/avatar_tag_bar.dart';

import 'package:drawme/models/avatar.dart';

class AvatarInfo extends StatelessWidget {
  final Avatar avatar;

  const AvatarInfo(
    this.avatar, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                avatar.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              AutoSizeText(
                avatar.author,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        AvatarTagBar(avatar: avatar),
        Container(
          height: 250,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                'Descrição:',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 210,
                child: SelectableText(avatar.description),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
