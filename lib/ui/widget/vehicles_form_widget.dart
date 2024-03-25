import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/ui/widget/vehicles_form/vehicles_form_cubit.dart';
import 'package:rg_track/ui/widget/vehicles_form/vehicles_form_state.dart';
import 'package:rg_track/utils/bool_extension.dart';
import 'package:rg_track/utils/types.dart';

class VehiclesFormWidget extends StatefulWidget {
  final bool enable;
  final Customer? customer;
  final ModelAction<List<Vehicle>>? onChange;
  final ModelAction<Vehicle>? onRemoved;
  final ModelAction<Vehicle>? onAdded;

  const VehiclesFormWidget({
    Key? key,
    this.customer,
    this.enable = true,
    this.onChange,
    this.onRemoved,
    this.onAdded,
  }) : super(key: key);

  @override
  State<VehiclesFormWidget> createState() => _VehiclesFormWidgetState();
}

class _VehiclesFormWidgetState extends State<VehiclesFormWidget> {
  late FocusNode _licensePlateFocus;

  TextEditingController _licensePlateCtrl = TextEditingController();
  final List<Vehicle> _vehicles = [];

  final BoxDecoration _commonBoxDecoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      border: Border.all(color: Colors.black26));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormTitle('Veículos'),
        GestureDetector(
          onTap: () {
            if (_licensePlateFocus.hasFocus) {
              _licensePlateFocus.unfocus();
            } else {
              FocusScope.of(context).requestFocus(_licensePlateFocus);
            }
          },
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 250,
            ),
            padding: const EdgeInsets.all(16),
            decoration: _commonBoxDecoration,
            child: SizedBox(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  ..._vehicles
                      .map((Vehicle e) => Chip(
                          label: Text(e.licensePlate!),
                          onDeleted: () {
                            if (widget.enable.not) return;
                            _vehicles.remove(e);
                            widget.onRemoved?.call(e);
                            widget.onChange?.call(_vehicles);
                            setState(() {});
                          }))
                      .toList(),
                  SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child:
                            BlocBuilder<VehiclesFormCubit, VehiclesFormState>(
                          builder:
                              (BuildContext context, VehiclesFormState state) {
                            List<Vehicle> vehicles = state.all;
                            return Autocomplete<Vehicle>(
                              onSelected: (Vehicle vehicle) {
                                _updateVehicle(vehicle, _vehicles);
                                _licensePlateCtrl.clear();
                              },
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) =>
                                      vehicles.where((Vehicle element) {
                                return element.licensePlate!
                                        .toLowerCase()
                                        .contains(textEditingValue.text
                                            .toLowerCase()) &&
                                    !_vehicles.any((Vehicle v) => element == v);
                              }).toList(),
                              optionsViewBuilder: (BuildContext context,
                                      onSelected, Iterable<Vehicle> options) =>
                                  Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  child: Container(
                                    height: 180,
                                    width: 250,
                                    decoration: _commonBoxDecoration,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: options
                                          .map((Vehicle e) => ListTile(
                                                title: Text(e.licensePlate!),
                                                onTap: () => onSelected(e),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController textEditingController,
                                  FocusNode focusNode,
                                  onFieldSubmitted) {
                                _licensePlateCtrl = textEditingController;
                                _licensePlateFocus = focusNode;
                                return TextFormField(
                                  controller: _licensePlateCtrl,
                                  focusNode: _licensePlateFocus,
                                  enableSuggestions: true,
                                  maxLines: 2,
                                  minLines: 1,
                                  onChanged: (String value) =>
                                      _handleRawTextInput(
                                          value, _licensePlateCtrl, _vehicles),
                                  onFieldSubmitted: (String value) =>
                                      _handleRawTextInput(
                                          value, _licensePlateCtrl, _vehicles),
                                  enabled: widget.enable,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void _handleRawTextInput(
    String value,
    TextEditingController? textEditingController,
    List<Vehicle> vehicles,
  ) {
    if (value.startsWith('\n')) textEditingController?.clear();
    if (value.trim().isEmpty) return;
    if (value.endsWith('\n')) {
      textEditingController?.clear();
      // _updateVehicle(Vehicle(licensePlate: value.toUpperCase()), vehicles);
    }
  }

  void _updateVehicle(Vehicle vehicle, List<Vehicle> vehicles) {
    if (vehicles.any((Vehicle v) =>
        v.licensePlate!.toUpperCase() == vehicle.licensePlate!.toUpperCase())) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Veículo ou Grupo de Veículos já adicionado'),
        backgroundColor: Colors.amber,
      ));
      return;
    }
    vehicles.add(vehicle);
    widget.onAdded?.call(vehicle);
    setState(() {});
    widget.onChange?.call(vehicles);
  }
}
