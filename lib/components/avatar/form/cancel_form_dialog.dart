import 'package:flutter/material.dart';

class CancelFormDialog extends StatelessWidget {
  const CancelFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Descartar alterações?'),
      content: const Text(
        'As alterações desta página não serão salvas.',
      ),
      actions: <Widget>[
        buildActionButton(
          context: context,
          onPressed: () => Navigator.pop(context, false),
          label: 'CANCELAR',
        ),
        buildActionButton(
          context: context,
          onPressed: () => Navigator.pop(context, true),
          label: 'SAIR',
        ),
      ],
    );
  }

  Widget buildActionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) =>
      TextButton(
        onPressed: onPressed,
        child: Text(label),
      );
}
