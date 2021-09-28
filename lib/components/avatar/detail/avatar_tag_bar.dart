import 'package:drawme/models/avatar/avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AvatarTagBar extends StatelessWidget {
  const AvatarTagBar(
    this.avatar, {
    Key? key,
  }) : super(key: key);

  final Avatar avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Icon(
              Icons.tag_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ...buildTagList(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildTagList(BuildContext context) => avatar.tags
      .map(
        (String tag) => Container(
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      )
      .toList();
}
