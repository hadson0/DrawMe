import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SaveAndShare extends StatefulWidget {
  const SaveAndShare({
    required this.onSaved,
    required this.onShared,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onSaved;
  final Future<void> Function() onShared;

  @override
  _SaveAndShareState createState() => _SaveAndShareState();
}

class _SaveAndShareState extends State<SaveAndShare> {
  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  Future<void> Function() get onSaved => widget.onSaved;
  Future<void> Function() get onShared => widget.onShared;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        overlayColor: Colors.black,
        overlayOpacity: 0.3,
        openCloseDial: isDialOpen,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.download),
            label: 'Baixar',
            onTap: onSaved,
          ),
          SpeedDialChild(
            child: const Icon(Icons.share),
            label: 'Compartilhar',
            onTap: onShared,
          ),
        ],
      ),
    );
  }
}
