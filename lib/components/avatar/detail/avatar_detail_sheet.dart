import 'dart:io';

import 'package:drawme/components/avatar/detail/avatar_info.dart';
import 'package:drawme/components/custom/custom_rounded_button.dart';
import 'package:drawme/models/avatar/avatar.dart';
import 'package:drawme/screens/avatar/painter/avatar_painter_screen.dart';
import 'package:flutter/material.dart';

class AvatarDetailSheet extends StatelessWidget {
  const AvatarDetailSheet(
    this.avatar, {
    Key? key,
  }) : super(key: key);

  final Avatar avatar;

  @override
  Widget build(BuildContext context) {
    return makeDismissible(
      context: context,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return DraggableScrollableSheet(
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
                  children: <Widget>[
                    SizedBox(
                      height: constraints.maxWidth,
                      width: constraints.maxWidth,
                      child: Image.file(
                        File(avatar.avatarSample),
                        fit: BoxFit.cover,
                      ),
                    ),
                    AvatarInfo(avatar),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomRoundedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('FECHAR'),
                        ),
                        CustomRoundedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              AvatarPainterScreen.route(avatar: avatar),
                            );
                          },
                          child: const Text('DESENHAR!'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget makeDismissible({
    required BuildContext context,
    required Widget child,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}
