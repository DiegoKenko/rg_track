import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/plan.dart';
import 'package:rg_track/ui/widget/card_cell.dart';
import 'package:rg_track/utils/types.dart';

class PlanCard extends StatelessWidget {
  final Plan plan;
  final ModelAction<Plan> onDeleteAction;
  final ModelAction<Plan> onShowAction;
  final ModelAction<Plan> onUpdateAction;

  const PlanCard(this.plan,
      {Key? key,
      required this.onDeleteAction,
      required this.onShowAction,
      required this.onUpdateAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16.0, bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CardCell('NOME', plan.name),
                    //ToDo: formatar para real
                    CardCell('VALOR POR VEÍCULO', plan.price),
                    CardCell('PERIODICIDADE', plan.period),
                    CardCell('STATUS', plan.isActive ? 'Ativo' : 'Inativo'),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => onDeleteAction(plan),
                    icon: Icon(MdiIcons.close),
                    tooltip: 'Delete',
                  ),
                  IconButton(
                    onPressed: () => onUpdateAction(plan),
                    icon: Icon(MdiIcons.fileEdit),
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    onPressed: () => onShowAction(plan),
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
