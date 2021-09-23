import 'package:flutter/material.dart';

class AvatarFormTagBar extends StatefulWidget {
  const AvatarFormTagBar({
    Key? key,
    required this.tagList,
    required this.onDeleteTapped,
  }) : super(key: key);

  final List<String> tagList;
  final Function(String) onDeleteTapped;

  @override
  State<AvatarFormTagBar> createState() => _AvatarFormTagBarState();
}

class _AvatarFormTagBarState extends State<AvatarFormTagBar> {
  Function(String) get onDeletedTapped => widget.onDeleteTapped;
  List<String> get tagList => widget.tagList;

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
              color: Colors.blue.shade900,
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

  List<Widget> _buildTagList() => tagList
      .map(
        (String tag) => Container(
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            height: 20,
            child: Row(
              children: <Widget>[
                Text(
                  tag,
                  style: TextStyle(color: Colors.blue.shade900),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      onDeletedTapped(tag);
                    });
                  },
                  child: const Icon(
                    Icons.highlight_remove_sharp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
      .toList();
}
