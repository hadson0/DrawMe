import 'package:drawme/components/avatar/form/cancel_form_dialog.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:drawme/screens/avatar/form/avatar_info_form_screen.dart';
import 'package:drawme/screens/avatar/form/image_selection_form_screen.dart';
import 'package:drawme/screens/avatar/form/layer_selection_form_screen.dart';
import 'package:flutter/material.dart';

class AvatarFormScreen extends StatefulWidget {
  const AvatarFormScreen({Key? key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const AvatarFormScreen(),
      );

  @override
  _AvatarFormScreenState createState() => _AvatarFormScreenState();
}

class _AvatarFormScreenState extends State<AvatarFormScreen> {
  final Canvas canvas = Canvas();

  int selectedScreenIndex = 0;

  bool get isLastScreen => selectedScreenIndex >= getScreens.length - 1;
  bool get isFirstScreen => selectedScreenIndex == 0;
  List<Widget> get getScreens => [
        LayerSelectionFormScreen(
          canvas: canvas,
          onNextPressed: onNextPressed,
        ),
        ImageSelectionFormScreen(
          canvas: canvas,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
        ),
        AvatarInfoFormScreen(
          canvas: canvas,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
        ),
      ];

  void onBackPressed() {
    if (!isFirstScreen) {
      setState(() => selectedScreenIndex--);
    }
  }

  void onNextPressed() {
    if (!isLastScreen) {
      setState(() => selectedScreenIndex++);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool? shouldPop = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return const CancelFormDialog();
          },
        );

        return shouldPop ?? false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Criar Avatar'),
          ),
          body: getScreens[selectedScreenIndex],
        ),
      ),
    );
  }
}
