import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/plan.dart';
import 'package:rg_track/ui/widget/single_child_scroll_bar_view.dart';
import 'package:rg_track/utils/types.dart';

class PlansTableView extends StatelessWidget {
  final List<Plan> plans;
  final ModelAction<Plan> onDeleteAction;
  final ModelAction<Plan> onShowAction;
  final ModelAction<Plan> onUpdateAction;

  const PlansTableView(
    this.plans, {
    Key? key,
    required this.onDeleteAction,
    required this.onShowAction,
    required this.onUpdateAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollBarView(
      child: DataTable(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        rows: List.generate(plans.length, (int index) {
          final Plan plan = plans[index];
          return DataRow(
              key: ValueKey("plan:${plan.id}"),
              color:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.grey.shade300;
                }
                return index.isEven
                    ? Colors.transparent
                    : Colors.grey.withOpacity(0.1);
              }),
              onLongPress: () {},
              cells: [
                DataCell(Text(plan.id.toString())),
                DataCell(Text(plan.name)),
                DataCell(Text(plan.price)),
                DataCell(Text(plan.period)),
                DataCell(Text(plan.isActive ? "Ativo" : "Inativo")),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () => onDeleteAction(plan),
                      icon: Icon(MdiIcons.close),
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      onPressed: () => onShowAction(plan),
                      icon: Icon(MdiIcons.eye),
                      tooltip: 'Visualizar',
                    ),
                    IconButton(
                      onPressed: () => onUpdateAction(plan),
                      icon: Icon(MdiIcons.fileEdit),
                      tooltip: 'Editar',
                    ),
                  ],
                ))
              ]);
        }),
        columns: [
          const DataColumn(label: Text('ID'), numeric: true),
          DataColumn(
              label: Container(
            constraints: const BoxConstraints(minWidth: 250),
            child: const Text('NOME'),
          )),
          const DataColumn(label: Text('VALOR POR VEÍCULO')),
          const DataColumn(label: Text('PERIODICIDADE')),
          const DataColumn(label: Text('STATUS')),
          const DataColumn(label: Text('AÇÕES')),
        ],
      ),
    );
  }
}
