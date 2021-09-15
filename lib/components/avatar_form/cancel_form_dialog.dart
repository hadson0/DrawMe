import 'package:flutter/material.dart';

import 'package:drawme/utils/AppRoutes.dart';

class CancelFormDialog extends StatelessWidget {
  const CancelFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tem Certeza?'),
      content: Text('Deseja cancelar o processo?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Não'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          },
          child: Text('Sim'),
        ),
      ],
    );
  }
}
