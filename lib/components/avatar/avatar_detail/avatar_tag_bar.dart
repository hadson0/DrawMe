import 'package:drawme/models/avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AvatarTagBar extends StatelessWidget {
  final Avatar avatar;

  const AvatarTagBar({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  List<Widget> _buildTagList() {
    return avatar.tags.map((avt) {
      return Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          avt,
          style: TextStyle(color: Colors.blue.shade900),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Icon(
              Icons.tag_rounded,
              color: Colors.blue.shade900,
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ..._buildTagList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
