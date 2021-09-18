import 'package:flutter/material.dart';

class AvatarFormTagBar extends StatefulWidget {
  final List<String> tagList;
  final Function(String) onDeleteTapped;

  const AvatarFormTagBar({
    Key? key,
    required List<String> tagList,
    required this.onDeleteTapped,
  })  : tagList = tagList,
        super(key: key);

  @override
  State<AvatarFormTagBar> createState() => _AvatarFormTagBarState();
}

class _AvatarFormTagBarState extends State<AvatarFormTagBar> {
  Function(String) get onDeletedTapped => widget.onDeleteTapped;

  List<String> get tagList => widget.tagList;

  List<Widget> _buildTagList() {
    return tagList.map((tag) {
      return Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 20,
          child: Row(
            children: [
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
                child: Icon(
                  Icons.highlight_remove_sharp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
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
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
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
          ),
        ],
      ),
    );
  }
}
