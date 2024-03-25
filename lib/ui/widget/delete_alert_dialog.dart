import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Confirma a exclusão?'),
        ],
      ),
      title: Icon(
        MdiIcons.closeCircleOutline,
        color: Colors.red,
        size: 75,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    'EXCLUIR',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text(
                    'MANTER',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        )
      ],
    );
  }
}
