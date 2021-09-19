import 'dart:io';

import 'package:drawme/components/avatar/avatar_detail/avatar_info.dart';
import 'package:drawme/models/avatar.dart';
import 'package:drawme/screens/avatar_overview/avatar_item/avatar_painter_screen.dart';
import 'package:flutter/material.dart';

class AvatarDetailSheet extends StatelessWidget {
  const AvatarDetailSheet(
    this.avatar, {
    Key? key,
  }) : super(key: key);
  
  final Avatar avatar;

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

    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.7,
        maxChildSize: 0.9,
        builder: (_, ScrollController controller) => ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: Container(
            color: Colors.white,
            child: ListView(
              controller: controller,
              children: <Widget> [
                SizedBox(
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
                  children: <Widget> [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Fechar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(AvatarPainterScreen.route(avatar: avatar));
                      },
                      child: const Text(
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
