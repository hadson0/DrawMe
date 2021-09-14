import 'package:flutter/material.dart';

import 'package:drawme/components/avatar/avatar_detail/avatar_tag_bar.dart';

import 'package:drawme/models/avatar.dart';

class AvatarInfo extends StatelessWidget {
  final Avatar avatar;

  const AvatarInfo({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                avatar.name,
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                avatar.author,
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
          /* TODO: Update description box */
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
