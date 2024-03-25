import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/vehicle_event.dart';
import 'package:rg_track/ui/events/cubit/vehicle_events_cubit.dart';
import 'package:rg_track/ui/events/cubit/vehicle_events_state.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/utils/bool_extension.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/types.dart';
import 'package:rg_track/utils/validator.dart';

class VehicleEventForm extends StatefulWidget {
  final ModelAction<VehicleEvent>? onSave;
  final WillPopUpAction<VehicleEvent>? willPopUp;
  final VehicleEvent? vehicleEvent;
  final bool enable;

  const VehicleEventForm({
    super.key,
    this.onSave,
    this.willPopUp,
    this.enable = true,
    this.vehicleEvent,
  });

  @override
  State<VehicleEventForm> createState() => _VehicleEventFormState();
}

class _VehicleEventFormState extends State<VehicleEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late VehicleEvent _vehicleEvent = VehicleEvent();
  final TextEditingController _nameCtrl = TextEditingController(),
      _descriptionCtrl = TextEditingController(),
      _messageCtrl = TextEditingController();

  final FocusNode _descriptionFocus = FocusNode(),
      _nameFocus = FocusNode(),
      _messageFocus = FocusNode(),
      _saveFocus = FocusNode();

  int? _groupValue;

  @override
  void initState() {
    _loadVehicleEventForm(widget.vehicleEvent ?? VehicleEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onWillPop: () async {
        return await widget.willPopUp?.call(_vehicleEvent) ?? true;
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: 128,
            left: context.onWideScreen(150, 16)!,
            top: context.onWideScreen(64, 0)!,
            right: context.onWideScreen(150, 16)!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormTitle('Evento'),
            Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.onWideScreen(300, null),
                    child: TextFormField(
                      controller: _nameCtrl,
                      focusNode: _nameFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_messageFocus);
                      },
                      validator: (String? value) {
                        return Validator(value).isRequired();
                      },
                      onChanged: (String value) {
                        _vehicleEvent.name = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Nome",
                        enabled: widget.enable,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.onWideScreen(225, null),
                    child: SwitchListTile(
                      title: const Text('Avisar Central'),
                      value: _vehicleEvent.alertCentral ?? false,
                      onChanged: (bool value) {
                        if (widget.enable.not) return;
                        _vehicleEvent.alertCentral = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    width: context.onWideScreen(225, null),
                    child: SwitchListTile(
                      title: const Text('Status'),
                      value: _vehicleEvent.active ?? false,
                      onChanged: (bool value) {
                        if (widget.enable.not) return;
                        _vehicleEvent.active = value;
                        setState(() {});
                      },
                    ),
                  )
                ]),
            const SizedBox(height: 16),
            SizedBox(
              width: context.onWideScreen(300, null),
              child: TextFormField(
                controller: _descriptionCtrl,
                focusNode: _descriptionFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_messageFocus);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  return Validator(value).isRequired();
                },
                onChanged: (String value) {
                  _vehicleEvent.description = value;
                },
                decoration: InputDecoration(
                  labelText: "Descrição",
                  enabled: widget.enable,
                ),
              ),
            ),
            const FormTitle('Dados complementares'),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              children: {
                "Vehicle.description": "Descrição (veículo)",
                "Vehicle.where": "Localização (veículo)",
                "Date": "Data",
                "Time": "Hora",
                "Vehicle.speed": "Velocidade (veículo)",
                "Vehicle.driver": "Motorista (veículo)",
                "Vehicle.licencePlate": "Placa (veículo)",
                "Vehicle.brand": "Marca (veículo)",
                "Vehicle.model": "Modelo (veículo)",
              }
                  .entries
                  .map((MapEntry<String, String> e) => ActionChip(
                      label: Text(e.value),
                      onPressed: () {
                        if (!widget.enable) return;
                        _messageFocus.unfocus();
                        if (_messageCtrl.selection.isValid) {
                          int end = _messageCtrl.selection.end;
                          _messageCtrl.text = _messageCtrl.text.replaceRange(
                              _messageCtrl.selection.start,
                              end,
                              "\${${e.key}}");
                        } else {
                          _messageCtrl.text += "\${${e.key}}";
                        }
                        _messageCtrl.selection = TextSelection.fromPosition(
                            TextPosition(offset: _messageCtrl.text.length));
                        FocusScope.of(context).requestFocus(_messageFocus);
                      }))
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              enabled: widget.enable,
              controller: _messageCtrl,
              focusNode: _messageFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_saveFocus);
              },
              textInputAction: TextInputAction.next,
              onChanged: (String value) {
                _vehicleEvent.message = value;
              },
              minLines: 5,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: "Mensagem",
                alignLabelWithHint: true,
                helperText:
                    "Não altere os valores que estiverem com a marcação \${referencia}.\nTodo valor inválido será removido.",
              ),
            ),
            const FormTitle('Prioridade'),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _makeRadio(60, 'Média (60 minutos)'),
                _makeRadio(30, 'Média (30 minutos)'),
                _makeRadio(15, 'Média (15 minutos)'),
              ],
            ),
            const SizedBox(height: 32),
            if (widget.enable)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      BlocConsumer<VehicleEventsCubit, VehicleEventsState>(
                        listener: _listenCubitStates,
                        builder:
                            (BuildContext context, VehicleEventsState state) =>
                                ElevatedButton(
                          onPressed: state is VehicleEventsStoreProcessingState
                              ? () {}
                              : () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context
                                        .read<VehicleEventsCubit>()
                                        .storeVehicleEvent(_vehicleEvent);
                                  }
                                },
                          focusNode: _saveFocus,
                          child: SizedBox(
                            width: context.onWideScreen(138, null),
                            height: 36,
                            child: Center(
                                child: Text(
                                    state is VehicleEventsStoreProcessingState
                                        ? 'Salvando..'
                                        : 'Salvar')),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  void _listenCubitStates(BuildContext context, VehicleEventsState state) {
    if (state is VehicleEventStoredFailsState) {
      // _errors = state;
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialogFails(exception: state.exception));
      _formKey.currentState?.validate();
    }
    if (state is VehicleEventStoredSuccessfulState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Evento salvo com sucesso!'),
        backgroundColor: Colors.green,
      ));
      _formKey.currentState?.reset();
    }

    if (state is VehicleEventLoadByIdState) {
      // _loadVehicleEventForm(state.driver);
      setState(() {});
    }
  }

  Widget _makeRadio(int duration, String label) => InkWell(
        onTap: widget.enable
            ? () {
                _groupValue = duration;
                _vehicleEvent.maxTime = duration;
                setState(() {});
              }
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<int>(
                value: duration,
                groupValue: _groupValue,
                onChanged: (_) {
                  if (!widget.enable) return;
                  _groupValue = duration;
                  _vehicleEvent.maxTime = duration;
                  setState(() {});
                }),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(label),
            ),
          ],
        ),
      );

  void _loadVehicleEventForm(VehicleEvent vehicleEvent) {
    _vehicleEvent = vehicleEvent;
    _nameCtrl.text = _vehicleEvent.name ?? '';
    _descriptionCtrl.text = _vehicleEvent.description ?? '';
    _messageCtrl.text = _vehicleEvent.message ?? '';
    _groupValue = _vehicleEvent.maxTime;
  }
}
