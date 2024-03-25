import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ms_list_utils/ms_list_utils.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/const/enum/enum_max_speed.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/model/vehicle_kind.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/vehicles/single/cubit/vehicle_single_cubit.dart';
import 'package:rg_track/ui/vehicles/single/cubit/vehicle_single_state.dart';
import 'package:rg_track/ui/vehicles/single/customer_tile.dart';
import 'package:rg_track/ui/vehicles/single/device_tile.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/disable_widget.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/currency_mask.dart';
import 'package:rg_track/utils/custom_input_formatters.dart';
import 'package:rg_track/utils/date_utils.dart';
import 'package:rg_track/utils/placaapi.dart';
import 'package:rg_track/utils/validator.dart';

class VehicleForm extends StatefulWidget {
  final Vehicle vehicle;
  final bool enable;
  final EnumFormOption formOption;

  const VehicleForm({
    required this.vehicle,
    required this.formOption,
    super.key,
    this.enable = true,
  });

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool saved = false;

  final TextEditingController _installationDateCtrl = TextEditingController(),
      _vehicleKindIdCtrl = TextEditingController(),
      _licensePlateCtrl = TextEditingController(),
      _colorCtrl = TextEditingController(),
      _renavamCtrl = TextEditingController(),
      _mileageCtrl = TextEditingController(),
      _manufacturerCtrl = TextEditingController(),
      _modelCtrl = TextEditingController(),
      _yearCtrl = TextEditingController(),
      _chassiCtrl = TextEditingController(),
      _ufCtrl = TextEditingController(),
      _securityQuestionCtrl = TextEditingController(),
      _securityAnswerCtrl = TextEditingController(),
      _observationsCtrl = TextEditingController(),
      _fleetCtrl = TextEditingController(),
      _specificationCtrl = TextEditingController(),
      _monthlyFeeCentsCtrl = CurrencyTextInputMaskController(),
      _kindOfFuelIdCtrl = TextEditingController(),
      _startsWorkAtCtrl = TextEditingController(),
/*       _output1Ctrl = TextEditingController(),
      _output2Ctrl = TextEditingController(),
      _output3Ctrl = TextEditingController(),
      _output4Ctrl = TextEditingController(); */
      _endsWorkAtCtrl = TextEditingController();

  final FocusNode _installationDateFocus = FocusNode(),
      _vehicleKindIdFocus = FocusNode(),
      _licensePlateFocus = FocusNode(),
      _colorFocus = FocusNode(),
      _renavamFocus = FocusNode(),
      _mileageFocus = FocusNode(),
      _manufacturerFocus = FocusNode(),
      _modelFocus = FocusNode(),
      _yearFocus = FocusNode(),
      _chassiFocus = FocusNode(),
      _ufFocus = FocusNode(),
      _securityQuestionFocus = FocusNode(),
      _securityAnswerFocus = FocusNode(),
      _observationsFocus = FocusNode(),
      _fleetFocus = FocusNode(),
      _specificationFocus = FocusNode(),
      _monthlyFeeCentsFocus = FocusNode(),
      /*   _startsWorkAtFocus = FocusNode(),
      _endsWorkAtFocus = FocusNode(),
      _output1Focus = FocusNode(),
      _output2Focus = FocusNode(),
      _output3Focus = FocusNode(),
      _output4Focus = FocusNode(), */
      _maxSpeedFocus = FocusNode(),
      _saveFocus = FocusNode(),
      _clientFocus = FocusNode();

  final MaskTextInputFormatter _maskDate =
      MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'\d')});

/*   final Set<Customer> _addedCustomers = {};
  final Set<Customer> _removedCustomers = {}; */

  bool get enable {
    return !(widget.formOption == EnumFormOption.VIEW);
  }

  @override
  void initState() {
    _loadVehicleForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocConsumer<VehicleSingleCubit, VehicleSingleState>(
          listener: (context, state) => _listenCubitStates(context, state),
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: 128,
                  left: context.onWideScreen(150, 16)!,
                  top: context.onWideScreen(50, 20)!,
                  right: context.onWideScreen(150, 16)!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*  const FormTitle('Periféricos'),
                  TagsManager<Peripheral>(
                    parseTitle: (Peripheral value) => value.title,
                    onChange: (List<Peripheral> model) {},
                  ), */
                  const FormTitle('Dados do veículo'),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      Disable(
                        disable: !widget.enable,
                        child: SizedBox(
                          width: context.onWideScreen(225, null),
                          child: DropdownButtonFormField<VehicleKind>(
                            focusNode: _vehicleKindIdFocus,
                            items: VehicleKind.values
                                .map<DropdownMenuItem<VehicleKind>>(
                                    (VehicleKind vehicleKind) =>
                                        DropdownMenuItem<VehicleKind>(
                                          value: vehicleKind,
                                          child: Text(vehicleKind.name),
                                        ))
                                .toList(),
                            validator: (VehicleKind? value) {
                              return Validator(value?.toString()).isRequired();
                            },
                            decoration: InputDecoration(
                              labelText: "Tipo*",
                              enabled: widget.enable,
                            ),
                            value: widget.vehicle.vehicleKind,
                            onChanged: (VehicleKind? value) {
                              if (value != null) {
                                widget.vehicle.vehicleKind = value;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                            enabled: widget.enable,
                            controller: _licensePlateCtrl,
                            focusNode: _licensePlateFocus,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_colorFocus);
                            },
                            textInputAction: TextInputAction.next,
                            onChanged: (String value) {
                              widget.vehicle.licensePlate = value.toUpperCase();
                              _loadPlateData(value);
                            },
                            decoration: InputDecoration(
                              labelText: "Placa",
                              enabled: widget.enable,
                            ),
                            validator: (String? value) {
                              return Validator(value).isRequired();
                            },
                            inputFormatters: [
                              UpperCaseTextInputFormatter(),
                              placaInputFormatter,
                            ],
                          )),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                            enabled: widget.enable,
                            controller: _colorCtrl,
                            focusNode: _colorFocus,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_renavamFocus);
                            },
                            textInputAction: TextInputAction.next,
                            onChanged: (String value) {
                              widget.vehicle.color = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Cor",
                            ),
                          )),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                            enabled: widget.enable,
                            controller: _renavamCtrl,
                            focusNode: _renavamFocus,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_mileageFocus);
                            },
                            textInputAction: TextInputAction.next,
                            onChanged: (String value) {
                              widget.vehicle.renavam = value;
                            },
                            validator: (String? value) {
                              return Validator(value).isRequiredConditional(
                                  () =>
                                      widget.vehicle.fineConsultation ==
                                      true)();
                            },
                            decoration: const InputDecoration(
                              labelText: "Renavam",
                            ),
                          )),
                      SizedBox(
                        width: context.onWideScreen(225, null),
                        child: TextFormField(
                          enabled: widget.enable,
                          controller: _mileageCtrl,
                          focusNode: _mileageFocus,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_manufacturerFocus);
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (String value) {
                            widget.vehicle.mileage = int.tryParse(value);
                          },
                          validator: (String? value) {
                            return Validator(value).min(0).isRequired();
                          },
                          decoration: const InputDecoration(
                            labelText: "Hodômetro",
                          ),
                        ),
                      ),
                      Disable(
                        disable: !widget.enable,
                        child: SizedBox(
                          width: context.onWideScreen(225, null),
                          child: DropdownButtonFormField<EnumMaxSpeed>(
                            focusNode: _maxSpeedFocus,
                            items: EnumMaxSpeed.values
                                .map<DropdownMenuItem<EnumMaxSpeed>>(
                                    (EnumMaxSpeed maxSpeed) =>
                                        DropdownMenuItem<EnumMaxSpeed>(
                                          value: maxSpeed,
                                          child:
                                              Text(maxSpeed.speed.toString()),
                                        ))
                                .toList(),
                            decoration: InputDecoration(
                              labelText: "Velocidade máxima",
                              enabled: widget.enable,
                            ),
                            value: widget.vehicle.maxSpeed,
                            onChanged: (EnumMaxSpeed? value) {
                              if (value != null) {
                                widget.vehicle.maxSpeed = value;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                            enabled: widget.enable,
                            controller: _manufacturerCtrl,
                            focusNode: _manufacturerFocus,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_modelFocus);
                            },
                            textInputAction: TextInputAction.next,
                            onChanged: (String value) {
                              widget.vehicle.manufacturer = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Marca",
                            ),
                          )),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                            enabled: widget.enable,
                            controller: _modelCtrl,
                            focusNode: _modelFocus,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_yearFocus);
                            },
                            textInputAction: TextInputAction.next,
                            onChanged: (String value) {
                              widget.vehicle.model = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Modelo",
                            ),
                          )),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                            enabled: widget.enable,
                            controller: _yearCtrl,
                            focusNode: _yearFocus,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_chassiFocus);
                            },
                            textInputAction: TextInputAction.next,
                            onChanged: (String value) {
                              widget.vehicle.year = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "Ano",
                            ),
                          )),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                            enabled: widget.enable,
                            controller: _chassiCtrl,
                            focusNode: _chassiFocus,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_ufFocus);
                            },
                            textInputAction: TextInputAction.next,
                            onChanged: (String value) {
                              widget.vehicle.chassi = value;
                            },
                            validator: (String? value) {
                              return Validator(value).isRequiredConditional(
                                  () =>
                                      widget.vehicle.fineConsultation ==
                                      true)();
                            },
                            decoration: const InputDecoration(
                              labelText: "Chassi",
                            ),
                          )),
                      Disable(
                        disable: !widget.enable,
                        child: SizedBox(
                            width: context.onWideScreen(225, null),
                            child: DropdownButtonFormField<String>(
                              focusNode: _ufFocus,
                              onChanged: (String? value) =>
                                  widget.vehicle.uf = value,
                              decoration: InputDecoration(
                                labelText: "UF",
                                enabled: widget.enable,
                              ),
                              validator: (String? value) {
                                return Validator(value).isRequiredConditional(
                                    () =>
                                        widget.vehicle.fineConsultation ==
                                        true)();
                              },
                              value: widget.vehicle.uf,
                              items: [
                                'AC',
                                'AL',
                                'AM',
                                'AP',
                                'BA',
                                'CE',
                                'DF',
                                'ES',
                                'GO',
                                'MA',
                                'MG',
                                'MS',
                                'MT',
                                'PA',
                                'PB',
                                'PE',
                                'PI',
                                'PR',
                                'RJ',
                                'RN',
                                'RO',
                                'RR',
                                'RS',
                                'SC',
                                'SE',
                                'SP',
                                'TO',
                              ]
                                  .map((String e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: context.onWideScreen(225, null),
                        child: TextFormField(
                          enabled: widget.enable,
                          controller: _securityQuestionCtrl,
                          focusNode: _securityQuestionFocus,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_securityAnswerFocus);
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (String value) {
                            widget.vehicle.securityQuestion = value;
                          },
                          decoration: const InputDecoration(
                            labelText: "Pergunta de segurança",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.onWideScreen(225, null),
                        child: TextFormField(
                          enabled: widget.enable,
                          controller: _securityAnswerCtrl,
                          focusNode: _securityAnswerFocus,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_observationsFocus);
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (String value) {
                            widget.vehicle.securityAnswer = value;
                          },
                          decoration: const InputDecoration(
                            labelText: "Resposta de segurança",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _observationsCtrl,
                    focusNode: _observationsFocus,
                    minLines: 3,
                    maxLines: 10,
                    onChanged: (String change) {
                      widget.vehicle.observations = change;
                    },
                    decoration: const InputDecoration(labelText: "Observações"),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: context.onWideScreen(225, null),
                        child: TextFormField(
                          enabled: widget.enable,
                          controller: _fleetCtrl,
                          focusNode: _fleetFocus,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_specificationFocus);
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (String value) {
                            widget.vehicle.fleet = value;
                          },
                          decoration: const InputDecoration(
                            labelText: "Frota",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.onWideScreen(225, null),
                        child: TextFormField(
                          enabled: widget.enable,
                          controller: _specificationCtrl,
                          focusNode: _specificationFocus,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_monthlyFeeCentsFocus);
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (String value) {
                            widget.vehicle.specification = value;
                          },
                          decoration: const InputDecoration(
                            labelText: "Especificação",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.onWideScreen(225, null),
                        child: TextFormField(
                          enabled: widget.enable,
                          controller: _monthlyFeeCentsCtrl,
                          focusNode: _monthlyFeeCentsFocus,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_clientFocus);
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (String value) {
                            widget.vehicle.monthlyFeeCents = int.tryParse(
                                value.replaceAll(RegExp(r"\D"), ""));
                          },
                          decoration: const InputDecoration(
                            labelText: "Valor por Veículo",
                          ),
                        ),
                      ),
                      /* Disable(
                        disable: !widget.enable,
                        child: SizedBox(
                          width: context.onWideScreen(225, null),
                          child: FutureBuilder<List<KindOfFuel>>(
                            initialData: _kindsOfFuel,
                            future: () {}(),
                            builder: (BuildContext context,
                                    AsyncSnapshot<List<KindOfFuel>> snapshot) =>
                                DropdownButtonFormField<KindOfFuel>(
                              focusNode: _kindOfFuelIdFocus,
                              onChanged: (KindOfFuel? value) {
                                widget.vehicle.kindOfFuelId = value?.id;
                                _kindOfFuel = value;
                              },
                              value: _kindOfFuel,
                              decoration: InputDecoration(
                                enabled: widget.enable,
                                labelText: "Tipo de Combustível",
                              ),
                              items: snapshot.data
                                  ?.map((KindOfFuel e) =>
                                      DropdownMenuItem<KindOfFuel>(
                                        value: e,
                                        child: Text(e.title),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ), */
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const FormTitle('Cliente'),
                  const SizedBox(height: 5),
                  FutureBuilder(
                      future: context
                          .read<VehicleSingleCubit>()
                          .getCustomers(AuthService.instance.user.id ?? ''),
                      builder: (context, snapClient) {
                        List<Customer> customers = [Customer(userParentId: '')];
                        if (snapClient.data != null) {
                          customers.addAll(snapClient.data!);
                        }
                        if (widget.vehicle.customer?.id?.isNotEmpty ?? false) {
                          Customer? customer = customers.firstWhereOrNull(
                              (e) => e.id == widget.vehicle.customer!.id);
                          if (customer != null) {
                            widget.vehicle.customer = customer;
                          }
                        }

                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.spaceBetween,
                          children: [
                            Disable(
                              disable: !widget.enable,
                              child: SizedBox(
                                width: context.onWideScreen(300, null),
                                child: DropdownButtonFormField<Customer>(
                                  value: customers.firstWhereOrNull((element) =>
                                      element.id ==
                                      widget.vehicle.customer?.id),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (Customer? value) {
                                    return Validator(value?.toString())();
                                  },
                                  onChanged: (Customer? value) {
                                    if (value != null) {
                                      widget.vehicle.customer = value;
                                    }
                                  },
                                  isDense: false,
                                  decoration: InputDecoration(
                                    labelText: "Cliente",
                                    enabled: widget.enable,
                                  ),
                                  items: customers
                                      .map<DropdownMenuItem<Customer>>(
                                          (Customer customer) =>
                                              DropdownMenuItem<Customer>(
                                                value: customer,
                                                child: CustomerTile(customer),
                                              ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  const SizedBox(height: 16),
                  const FormTitle("Equipamentos"),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: context.onWideScreen(300, null),
                        child: TextFormField(
                          controller: _installationDateCtrl,
                          focusNode: _installationDateFocus,
                          inputFormatters: [_maskDate],
                          onFieldSubmitted: (_) {
                            // FocusScope.of(context).requestFocus();
                          },
                          validator: (String? value) {
                            return Validator(value).isRequired.isDateDMY();
                          },
                          onChanged: (String value) {
                            if (value.length == 10) {
                              widget.vehicle.installationDate =
                                  dateFromStringDMY(value);
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Data da instalação*",
                              enabled: widget.enable,
                              hintText: 'DD/MM/AAAA',
                              suffixIcon: IconButton(
                                icon: Icon(MdiIcons.calendar),
                                onPressed: () {
                                  showDatePicker(
                                          helpText: 'Data da instalação',
                                          firstDate: DateTime(2000),
                                          initialDate: DateTime.now(),
                                          lastDate: DateTime(3000),
                                          context: context)
                                      .then((DateTime? value) {
                                    if (value != null) {
                                      widget.vehicle.installationDate = value;
                                      _installationDateCtrl.text =
                                          formatDataDMY(value) ?? '';
                                    }
                                  });
                                },
                              )),
                        ),
                      ),
                      FutureBuilder(
                          future: context
                              .read<VehicleSingleCubit>()
                              .loadDevicesOptions(AuthService.instance.user),
                          builder: (context, snapDevices) {
                            List<Device> devices = [Device()];
                            if (snapDevices.data != null) {
                              devices.addAll(snapDevices.data!);
                            }
                            if (widget.vehicle.deviceMainId?.isNotEmpty ??
                                false) {
                              Device? device = devices.firstWhereOrNull(
                                  (e) => e.id == widget.vehicle.deviceMainId);
                              if (device != null) {
                                widget.vehicle.newDeviceMain = device;
                              }
                            }
                            if (widget.vehicle.deviceRedundancyId?.isNotEmpty ??
                                false) {
                              Device? deviceRedundancy =
                                  devices.firstWhereOrNull((e) =>
                                      e.id ==
                                      widget.vehicle.deviceRedundancyId);
                              if (deviceRedundancy != null) {
                                widget.vehicle.newDeviceMain = deviceRedundancy;
                              }
                            }
                            return Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              alignment: WrapAlignment.spaceBetween,
                              runAlignment: WrapAlignment.spaceBetween,
                              children: [
                                Disable(
                                  disable: !widget.enable,
                                  child: SizedBox(
                                    width: context.onWideScreen(300, null),
                                    child: DropdownButtonFormField<Device>(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (Device? value) {
                                        return Validator(value?.toString())();
                                      },
                                      onChanged: (Device? value) {
                                        if (value != null) {
                                          widget.vehicle.newDeviceMain = value;
                                        }
                                      },
                                      isDense: false,
                                      decoration: InputDecoration(
                                        labelText: "Equipamento principal",
                                        enabled: widget.enable,
                                      ),
                                      value: devices.firstWhereOrNull(
                                          (element) =>
                                              element.id ==
                                              widget.vehicle.deviceMainId),
                                      items: devices
                                          .map<DropdownMenuItem<Device>>(
                                              (Device device) =>
                                                  DropdownMenuItem<Device>(
                                                    value: device,
                                                    child: DeviceTile(device),
                                                  ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Disable(
                                  disable: !widget.enable,
                                  child: SizedBox(
                                    width: context.onWideScreen(300, null),
                                    child: DropdownButtonFormField<Device>(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (Device? value) {
                                        if (value != null) {
                                          widget.vehicle.newDeviceRedundancy =
                                              value;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Equipamento de redundância",
                                        enabled: widget.enable,
                                      ),
                                      isDense: false,
                                      value: devices.firstWhereOrNull(
                                          (element) =>
                                              element.id ==
                                              widget
                                                  .vehicle.deviceRedundancyId),
                                      items: devices
                                          .map<DropdownMenuItem<Device>>(
                                              (Device device) =>
                                                  DropdownMenuItem<Device>(
                                                    value: device,
                                                    child: DeviceTile(device),
                                                  ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                  /*     const FormTitle('Motoristas'),
                  TagsManager<Driver>(
                    parseTitle: (Driver value) => value.title,
                    onChange: (List<Driver> model) {
                      // ToDo: definir relacionamento de motoristas no model
                    },
                  ),
                  const FormTitle(
                    'Saídas',
                    subtitle:
                        'Informe as saídas correspondentes de acordo com a instalação do equipamento.',
                  ),
                  TextFormField(
                    controller: _output1Ctrl,
                    focusNode: _output1Focus,
                    onChanged: (String value) {},
                    decoration: const InputDecoration(labelText: 'Saída 1'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _output2Ctrl,
                    focusNode: _output2Focus,
                    onChanged: (String value) {},
                    decoration: const InputDecoration(labelText: 'Saída 2'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _output3Ctrl,
                    focusNode: _output3Focus,
                    onChanged: (String value) {},
                    decoration: const InputDecoration(labelText: 'Saída 3'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _output4Ctrl,
                    focusNode: _output4Focus,
                    onChanged: (String value) {},
                    decoration: const InputDecoration(labelText: 'Saída 4'),
                  ),
                  const FormTitle('Eventos'),
                  SwitchListTile(
                      title: const Text('Excesso de velocidade'),
                      value: widget.vehicle.speeding ?? false,
                      onChanged: (bool value) {
                        widget.vehicle.speeding = value;
                        setState(() {});
                      }),
                  SwitchListTile(
                      title: const Text('Tempo parado'),
                      value: widget.vehicle.timeStill ?? false,
                      onChanged: (bool value) {
                        widget.vehicle.timeStill = value;
                        setState(() {});
                      }),
                  SwitchListTile(
                      title: const Text('Veículo sem transmissão'),
                      value: widget.vehicle.withoutTransmission ?? false,
                      onChanged: (bool value) {
                        widget.vehicle.withoutTransmission = value;
                        setState(() {});
                      }),
                  SwitchListTile(
                      title: const Text('Possui saida de bloqueio ativada'),
                      value: widget.vehicle.blockIngnition ?? false,
                      onChanged: (bool value) {
                        widget.vehicle.blockIngnition = value;
                        setState(() {});
                      }),
                  CustomerFormWidget.list(
                    onListChange: (List<Customer>? model) {
                      if (model != null) {
                        _addedCustomers.addAll(model);
                      }
                    },
                    onRemove: (Customer? model) {
                      if (model != null) _removedCustomers.add(model);
                    },
                    title: 'Espelho',
                    customers: const [],
                  ),
                  const FormTitle('Horário de operação'),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                            enabled: widget.enable,
                            controller: _startsWorkAtCtrl,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_endsWorkAtFocus);
                            },
                            focusNode: _startsWorkAtFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.datetime,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                  mask: '##:##',
                                  filter: {"#": RegExp(r'[0-9]')})
                            ],
                            onChanged: (String value) {
                              widget.vehicle.startsWorkAt = value;
                            },
                            decoration: InputDecoration(
                              labelText: "Início da Jornada",
                              hintText: '08:00',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: const TimeOfDay(
                                              hour: 8, minute: 0))
                                      .then((TimeOfDay? value) {
                                    if (value != null) {
                                      _startsWorkAtCtrl.text =
                                          value.format(context);
                                      widget.vehicle.startsWorkAt =
                                          value.format(context);
                                    }
                                  });
                                },
                                icon: Icon(MdiIcons.clockOutline),
                              ),
                            ),
                          )),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                            enabled: widget.enable,
                            controller: _endsWorkAtCtrl,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_endsWorkAtFocus);
                            },
                            focusNode: _endsWorkAtFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.datetime,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                  mask: '##:##',
                                  filter: {"#": RegExp(r'[0-9]')})
                            ],
                            onChanged: (String value) {
                              widget.vehicle.endsWorkAt = value;
                            },
                            decoration: InputDecoration(
                              labelText: "Termino da Jornada",
                              hintText: '18:00',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: const TimeOfDay(
                                              hour: 18, minute: 0))
                                      .then((TimeOfDay? value) {
                                    if (value != null) {
                                      _endsWorkAtCtrl.text =
                                          value.format(context);
                                      widget.vehicle.endsWorkAt =
                                          value.format(context);
                                    }
                                  });
                                },
                                icon: Icon(MdiIcons.clockOutline),
                              ),
                            ),
                          )),
                    ],
                  ),
                  const FormTitle('Verificação de multas'),
                  SwitchListTile(
                      title: const Text('Gerar alerta de multa'),
                      subtitle: const Text(
                          'Atenção, ao marcar essa opção ira gerar cobrança extra'),
                      value: widget.vehicle.fineConsultation ?? false,
                      onChanged: (bool value) => setState(() {
                            widget.vehicle.fineConsultation = value;
                          })),
                  */
                  const SizedBox(height: 32),
                  if (widget.enable && !saved)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (widget.formOption == EnumFormOption.CREATE) {
                                await context
                                    .read<VehicleSingleCubit>()
                                    .createVehicle(widget.vehicle);
                              }

                              if (widget.formOption == EnumFormOption.UPDATE) {
                                await context
                                    .read<VehicleSingleCubit>()
                                    .update(widget.vehicle);
                              }
                            }
                          },
                          focusNode: _saveFocus,
                          child: SizedBox(
                            width: 138,
                            height: 36,
                            child: Center(
                                child: Text(state is VehicleSingleLoadingState
                                    ? 'Salvando...'
                                    : 'Salvar')),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            );
          }),
    );
  }

  void _listenCubitStates(BuildContext context, VehicleSingleState state) {
    if (state is VehicleSingleErrorState) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialogFails(exception: state.exception));
      _formKey.currentState?.validate();
    }
    if (state is VehicleSingleSaveSuccessfulState) {
      saved = true;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Veículo salvo com sucesso!'),
        backgroundColor: Colors.green,
      ));
      _formKey.currentState?.reset();
      Navigator.of(context).pop();
    }
  }

  void _loadPlateData(String plate) async {
    if (Validator(plate).isRequired.isPlate() != null) return;
    final PlacaApi res = await licensePlate(plate, 'MarcusDuarte',
        const String.fromEnvironment('PLACAAPI_PASSWORD'));
    _colorCtrl.text = res.colour;
    _manufacturerCtrl.text = res.carMake;
    _chassiCtrl.text = res.vin;
    _modelCtrl.text = res.carModel;
    _yearCtrl.text = res.registrationYear;
    widget.vehicle.uf = res.uf;
    setState(() {});
  }

  void _loadVehicleForm() {
    _installationDateCtrl.text =
        formatDataDMY(widget.vehicle.installationDate) ?? '';

    _vehicleKindIdCtrl.text = widget.vehicle.vehicleKind?.toString() ?? '';
    _licensePlateCtrl.text = widget.vehicle.licensePlate ?? '';
    _colorCtrl.text = widget.vehicle.color ?? '';
    _renavamCtrl.text = widget.vehicle.renavam ?? '';
    _mileageCtrl.text = widget.vehicle.mileage?.toString() ?? '';
    _manufacturerCtrl.text = widget.vehicle.manufacturer ?? '';
    _modelCtrl.text = widget.vehicle.model ?? '';
    _yearCtrl.text = widget.vehicle.year ?? '';
    _chassiCtrl.text = widget.vehicle.chassi ?? '';
    _ufCtrl.text = widget.vehicle.uf ?? '';
    _securityQuestionCtrl.text = widget.vehicle.securityQuestion ?? '';
    _securityAnswerCtrl.text = widget.vehicle.securityAnswer ?? '';
    _observationsCtrl.text = widget.vehicle.observations ?? '';
    _fleetCtrl.text = widget.vehicle.fleet ?? '';
    _specificationCtrl.text = widget.vehicle.specification ?? '';
    _monthlyFeeCentsCtrl.text =
        widget.vehicle.monthlyFeeCents?.toString() ?? '';
    _kindOfFuelIdCtrl.text = widget.vehicle.kindOfFuelId?.toString() ?? '';
    _startsWorkAtCtrl.text = widget.vehicle.startsWorkAt ?? '';
    _endsWorkAtCtrl.text = widget.vehicle.endsWorkAt ?? '';
  }
}
