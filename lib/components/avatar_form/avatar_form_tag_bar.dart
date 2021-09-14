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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.tag_rounded,
            color: Colors.blue.shade900,
          ),
          SizedBox(width: 6),
          SingleChildScrollView(
            child: Row(
              children: widget.tagList.map((tag) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  child: Container(
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
