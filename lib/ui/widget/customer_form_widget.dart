import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ms_list_utils/ms_list_utils.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/utils/screen_utils.dart';
import 'package:rg_track/utils/types.dart';
import 'package:rg_track/utils/validator.dart';

class CustomerFormWidget extends StatefulWidget {
  final String title;

  final ModelAction<Customer?>? onSelect;
  final ModelAction<List<Customer>?>? onListChange;
  final ModelAction<Customer?>? onAdd;
  final ModelAction<Customer?>? onRemove;

  final List<Customer> customers;
  final List<Customer>? initialSelectedCustomers;
  final Customer? initialValue;

  final bool isRequired;
  final bool enable;
  final FocusNode? focus, nextFocus;
  final EdgeInsets? padding;

  const CustomerFormWidget({
    Key? key,
    required this.onSelect,
    required this.customers,
    this.title = "Cliente",
    this.isRequired = true,
    this.focus,
    this.nextFocus,
    this.enable = true,
    this.padding,
    this.initialValue,
  })  : onListChange = null,
        onAdd = null,
        onRemove = null,
        initialSelectedCustomers = null,
        super(key: key);

  const CustomerFormWidget.list({
    Key? key,
    required this.onListChange,
    required this.customers,
    this.title = "Cliente",
    this.onRemove,
    this.onAdd,
    this.isRequired = false,
    this.focus,
    this.nextFocus,
    this.enable = true,
    this.padding,
    this.initialValue,
    this.initialSelectedCustomers = const [],
  })  : onSelect = null,
        super(key: key);

  @override
  State<CustomerFormWidget> createState() => _CustomerFormWidgetState();
}

class _CustomerFormWidgetState extends State<CustomerFormWidget> {
  final List<Customer> _selectedCustomers = [];
  Customer? _customerSelected;
  int _numberOfSelectedCustomers = 1;

  @override
  void initState() {
    _selectedCustomers.addAll(widget.initialSelectedCustomers ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setSelectedCustomer();
    return IgnorePointer(
      ignoring: !widget.enable,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormTitle(widget.title),
          Container(
            padding: widget.padding,
            width: getWidthSize(context, sm: 500)?.toDouble(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List<Widget>.generate(
                _numberOfSelectedCustomers,
                (int index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 350,
                      child: DropdownButtonFormField<Customer>(
                        decoration: InputDecoration(
                            enabled: widget.enable,
                            labelText: "Selecione o cliente"),
                        focusNode: widget.focus,
                        onChanged: (Customer? customer) {
                          if (widget.onListChange != null) {
                            _updateListCustomer(customer, index);
                          } else {
                            _updateSingleCustomer(customer);
                          }
                        },
                        value: _getCustomerSelected(index),
                        validator: widget.isRequired
                            ? (Customer? value) =>
                                Validator(value?.toString()).isRequired()
                            : null,
                        items: widget.customers
                            .where((Customer customer) =>
                                !_selectedCustomers.contains(customer) ||
                                customer == _getCustomerSelected(index))
                            .map((Customer e) => DropdownMenuItem<Customer>(
                                  value: e,
                                  child: Text(e.fantasyName ??
                                      e.fullName ??
                                      "Cliente ID: ${e.id}"),
                                ))
                            .toList(),
                      ),
                    ),
                    if (widget.onListChange != null &&
                        index < _numberOfSelectedCustomers - 1)
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        height: 48,
                        width: 48,
                        margin: const EdgeInsets.only(left: 8.0),
                        child: IconButton(
                            onPressed: () {
                              Customer customer =
                                  _selectedCustomers.removeAt(index);
                              _numberOfSelectedCustomers--;
                              setState(() {});
                              widget.onRemove?.call(customer);
                              widget.onListChange?.call(_selectedCustomers);
                            },
                            icon: Icon(MdiIcons.close, color: Colors.white)),
                      )
                  ],
                ),
              ).addBetween((int index, _, __) => const SizedBox(height: 16)),
            ),
          ),
        ],
      ),
    );
  }

  void _updateListCustomer(Customer? customer, int index) {
    if (customer != null) {
      _selectedCustomers.insert(index, customer);
      _numberOfSelectedCustomers++;
      setState(() {});
      widget.onListChange?.call(_selectedCustomers);
      widget.onAdd?.call(customer);
    }
  }

  void _updateSingleCustomer(Customer? customer) {
    widget.onSelect?.call(customer);
    _customerSelected = customer;
    setState(() {});
    widget.focus?.unfocus();
    widget.nextFocus?.requestFocus();
  }

  Customer? _getCustomerSelected(int index) {
    if (widget.onListChange != null) {
      return _selectedCustomers.length > index
          ? _selectedCustomers[index]
          : null;
    } else {
      return _customerSelected;
    }
  }

  void _setSelectedCustomer() {
    if (widget.initialValue == null) return;
    if (_customerSelected != null) return;
    _customerSelected = widget.customers
        .firstWhereOrNull((Customer c) => c.id == widget.initialValue?.id);
  }
}
