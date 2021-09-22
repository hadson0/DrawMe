import 'package:drawme/components/avatar_form/cancel_form_dialog.dart';
import 'package:drawme/models/avatar/canvas.dart';
import 'package:drawme/screens/avatar_form/image_selection_form_screen.dart';
import 'package:drawme/screens/avatar_form/layer_selection_form_screen.dart';
import 'package:flutter/material.dart';

class AvatarFormScreen extends StatefulWidget {
  const AvatarFormScreen({Key? key}) : super(key: key);

  @override
  _AvatarFormScreenState createState() => _AvatarFormScreenState();
}

class _AvatarFormScreenState extends State<AvatarFormScreen> {
  int currentStep = 0;

  final Canvas canvas = Canvas();

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
          appBar: AppBar(
            title: const Text('Criar Avatar'),
          ),
          body: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              setState(() => currentStep++);
            },
            onStepCancel: () {
              setState(() => currentStep--);
            },
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: const Text('Camadas'),
          content: Container(),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Text('Imagens'),
          content: Container(),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text('Info'),
          content: Container(),
        ),
      ];
}
