import 'dart:io';

import 'package:drawme/screens/avatar_overview/avatar_item/avatar_painter_screen.dart';
import 'package:drawme/models/canvas.dart';
import 'package:flutter/material.dart';

import 'package:drawme/components/avatar/avatar_detail/avatar_info.dart';

import 'package:drawme/models/avatar.dart';

class AvatarDetailSheet extends StatelessWidget {
  final Avatar avatar;
  const AvatarDetailSheet(
    this.avatar, {
    Key? key,
  }) : super(key: key);

  Widget makeDismissible({
    required BuildContext context,
    required Widget child,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(avatar.canvas.layers[LayerNames.BACKGROUND]);

    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.7,
        maxChildSize: 0.9,
        builder: (_, controller) => ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: Container(
            color: Colors.white,
            child: ListView(
              controller: controller,
              children: [
                Container(
                  height: 310,
                  width: double.infinity,
                  child: Image.file(
                    File(avatar.avatarSample),
                    fit: BoxFit.cover,
                  ),
                ),
                AvatarInfo(avatar),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Fechar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(AvatarPainterScreen.route(avatar: avatar));
                      },
                      child: Text(
                        'Desenhar!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
