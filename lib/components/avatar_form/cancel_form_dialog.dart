import 'package:flutter/material.dart';

class CancelFormDialog extends StatelessWidget {
  const CancelFormDialog( {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Descartar alterações?'),
      content: const Text('As alterações desta página não serão salvas.'),
      actions: <Widget> [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Sair'),
        ),
      ],
    );
  }
}
