import 'package:flutter/material.dart';

class AvatarFormTagBar extends StatelessWidget {
  const AvatarFormTagBar({
    required this.tagList,
    Key? key,
  }) : super(key: key);

  final List<String> tagList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    ..._buildTagList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTagList() => tagList.map(
        (String tag) {
          if (tag != '') {
            return Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 20,
                child: Text(tag),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ).toList();
}
