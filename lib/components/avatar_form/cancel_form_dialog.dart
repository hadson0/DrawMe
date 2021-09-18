import 'package:drawme/utils/AppRoutes.dart';
import 'package:flutter/material.dart';

class CancelFormDialog extends StatelessWidget {
  const CancelFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tem Certeza?'),
      content: const Text('Deseja cancelar o processo?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Não'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          },
          child: const Text('Sim'),
        ),
      ],
    );
  }
}
