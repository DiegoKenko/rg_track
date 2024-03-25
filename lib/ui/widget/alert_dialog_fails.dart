import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/error_entity.dart';

class AlertDialogFails extends StatelessWidget {
  final ErrorEntity exception;
  final bool actionEnable;

  const AlertDialogFails({
    super.key,
    required this.exception,
    this.actionEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        height: 200,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(MdiIcons.closeCircleOutline, color: Colors.red, size: 75),
                const SizedBox(height: 32),
                Text(exception.code.description,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 32),
                Text(exception.message, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
      actions: actionEnable
          ? [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: Center(child: Text('TENTAR NOVAMENTE')),
                  )),
            ]
          : [],
    );
  }
}
