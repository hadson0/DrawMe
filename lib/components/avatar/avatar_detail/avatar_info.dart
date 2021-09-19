import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawme/components/avatar/avatar_detail/avatar_tag_bar.dart';
import 'package:drawme/models/avatar.dart';
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
      children: <Widget> [
        Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              AutoSizeText(
                avatar.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              AutoSizeText(
                avatar.author,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget> [
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
