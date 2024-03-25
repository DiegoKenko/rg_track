import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/ui/widget/single_child_scroll_bar_view.dart';
import 'package:rg_track/utils/types.dart';

class CustomersTableView extends StatelessWidget {
  final List<Customer> customers;
  final ModelAction<Customer> onDeleteAction;
  final ModelAction<Customer> onShowAction;
  final ModelAction<Customer> onUpdateAction;

  const CustomersTableView(
    this.customers, {
    Key? key,
    required this.onDeleteAction,
    required this.onShowAction,
    required this.onUpdateAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollBarView(
      key: const Key('customers_table_view'),
      child: DataTable(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        rows: List.generate(customers.length, (int index) {
          final Customer customer = customers[index];
          return DataRow(
              key: ValueKey("customer:${customer.id}"),
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
                DataCell(Text(customer.simpleID)),
                DataCell(Text(customer.bestName)),
                DataCell(Text(customer.document ?? '')),
                DataCell(Text(customer.bestPhoneNumber)),
                DataCell(Text(customer.status ?? '')),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () => onDeleteAction(customer),
                      icon: Icon(MdiIcons.close),
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      onPressed: () => onShowAction(customer),
                      icon: Icon(MdiIcons.eye),
                      tooltip: 'Visualizar',
                    ),
                    IconButton(
                      onPressed: () => onUpdateAction(customer),
                      icon: Icon(MdiIcons.fileEdit),
                      tooltip: 'Editar',
                    ),
                  ],
                )),
              ]);
        }),
        columns: [
          const DataColumn(
            label: Text('ID'),
            numeric: true,
          ),
          DataColumn(
            label: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 200),
                child: const Text('NOME / RAZÃO SOCIAL')),
          ),
          const DataColumn(
            label: Text('CPF / CNPJ'),
          ),
          const DataColumn(
            label: Text('TELEFONE'),
          ),
          const DataColumn(
            label: Text('STATUS'),
          ),
          const DataColumn(
            label: Text('AÇÕES'),
          ),
        ],
      ),
    );
  }
}
