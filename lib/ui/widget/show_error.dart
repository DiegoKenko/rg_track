import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/error_entity.dart';

class ShowError extends StatelessWidget {
  final ErrorEntity? exception;

  const ShowError(this.exception, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            MdiIcons.serverNetworkOff,
            size: 75,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            exception?.toString() ?? 'Um erro ocorreu',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
