import 'package:flutter/material.dart';

import 'package:drawme/components/avatar_name_bar.dart';
import 'package:drawme/components/avatar_tag_bar.dart';

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
        AvatarNameBar(avatar),
        AvatarTagBar(avatar),
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
                height: 6,
              ),
              SingleChildScrollView(child: Text(avatar.description)),
            ],
          ),
        ),
      ],
    );
  }
}

