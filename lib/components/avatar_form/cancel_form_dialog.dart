import 'package:flutter/material.dart';

class CancelFormDialog extends StatelessWidget {
  const CancelFormDialog(
    this.ctx, {
    Key? key,
  }) : super(key: key);
  
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Descartar alterações?'),
      content: const Text('As alterações desta página não serão salvas.'),
      actions: <Widget> [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Sair'),
        ),
      ],
    );
  }
}
