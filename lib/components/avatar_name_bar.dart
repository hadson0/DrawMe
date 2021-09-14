import 'package:flutter/material.dart';

import 'package:drawme/models/avatar.dart';

class AvatarNameBar extends StatelessWidget {
  final Avatar avatar;

  const AvatarNameBar({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
