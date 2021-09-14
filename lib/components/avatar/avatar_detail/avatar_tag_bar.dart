import 'package:flutter/material.dart';

import 'package:drawme/models/avatar.dart';

class AvatarTagBar extends StatelessWidget {
  final Avatar avatar;

  const AvatarTagBar({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
      ),
      child: Row(
        children: [
          Icon(
            Icons.tag_rounded,
            color: Colors.blue.shade900,
          ),
          SizedBox(width: 6),
          /* TODO: Configure row scroll */
          SingleChildScrollView(
            child: Row(
              children: avatar.tags.map((avt) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      avt,
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
