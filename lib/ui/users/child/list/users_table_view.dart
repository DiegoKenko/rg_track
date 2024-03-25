import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/ui/widget/single_child_scroll_bar_view.dart';
import 'package:rg_track/utils/types.dart';

class UsersTableView extends StatelessWidget {
  final List<UserEntity> users;
  final ModelAction<UserEntity> onStatusChangeAction;
  final ModelAction<UserEntity> onDeleteAction;
  final ModelAction<UserEntity> onShowAction;
  final ModelAction<UserEntity> onUpdateAction;

  const UsersTableView(this.users,
      {super.key,
      required this.onStatusChangeAction,
      required this.onDeleteAction,
      required this.onShowAction,
      required this.onUpdateAction});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollBarView(
      child: DataTable(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        rows: List.generate(users.length, (int index) {
          final UserEntity user = users[index];
          return DataRow(
              key: ValueKey("user:${user.id}"),
              color: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) =>
                      index.isEven ? Colors.white : Colors.grey.shade100),
              cells: [
                DataCell(Text(user.simpleID)),
                DataCell(Text(user.name ?? '')),
                DataCell(Text(user.email ?? '')),
                DataCell(Text(user.document ?? '')),
                DataCell(Text(user.statusFormatted,
                    style: TextStyle(
                        color: user.status == 'active'
                            ? Colors.green
                            : Colors.red))),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () => onStatusChangeAction(user),
                      icon: Icon(MdiIcons.lockOutline),
                      tooltip: 'Atualizar Status',
                    ),
                    IconButton(
                      onPressed: () => onDeleteAction(user),
                      icon: Icon(MdiIcons.close),
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      onPressed: () => onShowAction(user),
                      icon: Icon(MdiIcons.eye),
                      tooltip: 'Visualizar',
                    ),
                    IconButton(
                      onPressed: () => onUpdateAction(user),
                      icon: Icon(MdiIcons.fileEdit),
                      tooltip: 'Editar',
                    ),
                  ],
                )),
              ]);
        }),
        columns: const [
          DataColumn(label: Text('ID'), numeric: true),
          DataColumn(label: Text('NOME')),
          DataColumn(label: Text('E-MAIL')),
          DataColumn(label: Text('CLIENTE')),
          DataColumn(label: Text('STATUS')),
          DataColumn(label: Text('AÇÕES')),
        ],
      ),
    );
  }
}
