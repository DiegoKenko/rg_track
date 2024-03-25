import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/ui/widget/card_cell.dart';
import 'package:rg_track/ui/widget/elavated.dart';
import 'package:rg_track/utils/types.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final ModelAction<UserEntity> onDeleteAction;
  final ModelAction<UserEntity> onShowAction;
  final ModelAction<UserEntity> onUpdateAction;

  const UserCard(this.user,
      {Key? key,
      required this.onDeleteAction,
      required this.onShowAction,
      required this.onUpdateAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Elevated(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 0.5,
            ),
            gradient: const LinearGradient(
              stops: [0.0, 0.9],
              colors: [
                Color.fromARGB(255, 231, 231, 231),
                Colors.white,
              ],
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CardCell('USUÁRIO', user.name!),
                    CardCell('EMAIL', user.email!),
                    CardCell('TELEFONE', user.phone ?? 'Não informado'),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => onDeleteAction(user),
                    icon: Icon(MdiIcons.lockOutline),
                    tooltip: 'Status',
                  ),
                  IconButton(
                    onPressed: () => onDeleteAction(user),
                    icon: Icon(MdiIcons.close),
                    tooltip: 'Delete',
                  ),
                  IconButton(
                    onPressed: () => onUpdateAction(user),
                    icon: Icon(MdiIcons.fileEdit),
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    onPressed: () => onShowAction(user),
                    icon: Icon(MdiIcons.eye),
                    tooltip: 'Visualizar',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
