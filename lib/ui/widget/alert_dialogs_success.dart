import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/types.dart';

class AlertDialogSuccess extends StatelessWidget {
  final String itemName;
  final Callback onNew;
  final String? action;

  const AlertDialogSuccess({
    super.key,
    required this.itemName,
    required this.onNew,
    this.action,
  });

  const AlertDialogSuccess.created({
    super.key,
    required this.itemName,
    required this.onNew,
  }) : action = 'cadastrado';

  const AlertDialogSuccess.removed({
    super.key,
    required this.itemName,
    required this.onNew,
  }) : action = 'removido';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(MdiIcons.checkCircleOutline, color: Colors.green, size: 75),
          const SizedBox(height: 16),
          Text('$itemName $action com sucesso!',
              style: const TextStyle(fontSize: 18)),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: SizedBox(
            width: context.onWideScreen(138, null),
            height: 32,
            child: const Center(child: Text('FECHAR')),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              onNew();
            },
            child: SizedBox(
              width: context.onWideScreen(138, null),
              height: 32,
              child: const Center(child: Text('CADASTRAR OUTRO')),
            )),
      ],
    );
  }
}
