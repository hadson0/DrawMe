import 'package:flutter/material.dart';

class CancelFormDialog extends StatelessWidget {
  const CancelFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        'Descartar alterações?',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: const Text(
        'As alterações desta página não serão salvas.',
        style: TextStyle(
          color: Colors.white70,
        ),
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
        onPressed: () => Navigator.pop(context, true),
        child: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).indicatorColor,
          ),
        ),
      );
}
