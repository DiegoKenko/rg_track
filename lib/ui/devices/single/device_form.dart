import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ms_list_utils/ms_list_utils.dart';
import 'package:rg_track/const/devices_supported.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/ui/devices/single/cubit/device_single_cubit.dart';
import 'package:rg_track/ui/devices/single/cubit/device_single_state.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/disable_widget.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/date_utils.dart';
import 'package:rg_track/utils/validator.dart';

class DeviceForm extends StatefulWidget {
  final Device device;
  final EnumFormOption formOption;

  const DeviceForm({
    super.key,
    required this.device,
    required this.formOption,
  });

  @override
  State<DeviceForm> createState() => _DeviceFormState();
}

class _DeviceFormState extends State<DeviceForm> {
  bool enable = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _brandCtrl = TextEditingController(),
      _modelCtrl = TextEditingController(),
      _serialCtrl = TextEditingController(),
      _imeiCtrl = TextEditingController(),
      _passwordCtrl = TextEditingController(),
      _firmwareVersionCtrl = TextEditingController(),
      _mobileOperatorCtrl = TextEditingController(),
      _habilitatedAtCtrl = TextEditingController(),
      _simNumberCtrl = TextEditingController(),
      _simPinCtrl = TextEditingController(),
      _simIccidCtrl = TextEditingController(),
      _simPukCtrl = TextEditingController(),
      _simApnCtrl = TextEditingController(),
      _simApnUserCtrl = TextEditingController(),
      _simApnPasswordCtrl = TextEditingController();

  final FocusNode _brandFocus = FocusNode(),
      _modelFocus = FocusNode(),
      _serialFocus = FocusNode(),
      _imeiFocus = FocusNode(),
      _passwordFocus = FocusNode(),
      _firmwareVersionFocus = FocusNode(),
      _mobileOperatorFocus = FocusNode(),
      _habilitatedAtFocus = FocusNode(),
      _simNumberFocus = FocusNode(),
      _simPinFocus = FocusNode(),
      _simIccidFocus = FocusNode(),
      _simPukFocus = FocusNode(),
      _simApnFocus = FocusNode(),
      _simApnUserFocus = FocusNode(),
      _simApnPasswordFocus = FocusNode(),
      _saveFocus = FocusNode();

  final MaskTextInputFormatter _imeiMask = MaskTextInputFormatter(
      mask: '###############', filter: {"#": RegExp(r'[0-9]')});
  final MaskTextInputFormatter _sinCardMask = MaskTextInputFormatter(
      mask: '+## (##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  bool saved = false;

  void _loadDeviceForm() {
    _brandCtrl.text = widget.device.brand?.description ?? '';
    _modelCtrl.text = widget.device.model?.description ?? '';
    _serialCtrl.text = widget.device.serial ?? '';
    _imeiCtrl.text = widget.device.imei ?? '';
    _passwordCtrl.text = widget.device.password ?? '';
    _firmwareVersionCtrl.text = widget.device.firmwareVersion ?? '';
    _mobileOperatorCtrl.text = widget.device.mobileOperator ?? '';
    _habilitatedAtCtrl.text = formatDataDMY(widget.device.habilitatedAt) ?? '';
    _simNumberCtrl.text = widget.device.simNumber ?? '';
    _simPinCtrl.text = widget.device.simPin ?? '';
    _simIccidCtrl.text = widget.device.simIccid ?? '';
    _simPukCtrl.text = widget.device.simPuk ?? '';
    _simApnCtrl.text = widget.device.simApn ?? '';
    _simApnUserCtrl.text = widget.device.simApnUser ?? '';
    _simApnPasswordCtrl.text = widget.device.simApnPassword ?? '';
  }

  @override
  void initState() {
    enable = !(widget.formOption == EnumFormOption.VIEW);
    _loadDeviceForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onWillPop: () async {
        return true;
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: 128,
            left: context.onWideScreen(150, 16)!,
            top: context.onWideScreen(64, 0)!,
            right: context.onWideScreen(150, 16)!),
        child: BlocConsumer<DeviceSingleCubit, DeviceSingleState>(
            listener: _listenCubitStates,
            builder: (BuildContext context, DeviceSingleState state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const FormTitle("Dados do equipamento"),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      Disable(
                        disable: !enable,
                        child: SizedBox(
                          width: context.onWideScreen(225, null),
                          child: DropdownButtonFormField<String>(
                            focusNode: _brandFocus,
                            items: EnumBrand.values
                                .map((e) => DropdownMenuItem(
                                      value: e.description,
                                      child: Text(e.description),
                                    ))
                                .toList(),
                            value: widget.device.brand?.description,
                            hint: const Text("Marca*"),
                            isExpanded: true,
                            validator: (String? value) =>
                                Validator(value, field: "Marca")
                                    .isRequired
                                    .resultFirst(),
                            onChanged: (String? value) {
                              setState(() {
                                if (widget.device.brand != value) {
                                  widget.device.brand = EnumBrand.values
                                      .firstWhereOrNull(
                                          (p0) => p0.description == value);
                                  widget.device.model = EnumModel.values
                                      .firstWhereOrNull(
                                          (p0) => p0.description == value);
                                }
                                _modelFocus.requestFocus();
                              });
                            },
                          ),
                        ),
                      ),
                      Disable(
                        disable: !enable,
                        child: SizedBox(
                            width: context.onWideScreen(225, null),
                            child: DropdownButtonFormField<String>(
                              focusNode: _modelFocus,
                              items: EnumBrand.values
                                      .firstWhereOrNull((p0) =>
                                          p0.description ==
                                          widget.device.brand?.description)
                                      ?.models
                                      .map((e) => DropdownMenuItem(
                                            value: e.description,
                                            child: Text(e.description),
                                          ))
                                      .toList() ??
                                  [],
                              value: widget.device.model?.description,
                              hint: const Text("Modelo*"),
                              isExpanded: false,
                              validator: (String? value) {
                                return Validator(value, field: 'Modelo')
                                    .isRequired
                                    .resultFirst();
                              },
                              onChanged: (String? value) {
                                setState(() {
                                  widget.device.model = EnumModel.values
                                      .firstWhereOrNull(
                                          (p0) => p0.description == value);
                                  _serialFocus.requestFocus();
                                });
                              },
                            )),
                      ),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('serial'),
                              enabled: enable,
                              controller: _serialCtrl,
                              focusNode: _serialFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                _serialFocus.unfocus();
                                FocusScope.of(context).requestFocus(_imeiFocus);
                              },
                              onChanged: (String value) {
                                widget.device.serial = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "Serial",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('imei'),
                              enabled:
                                  widget.formOption == EnumFormOption.CREATE,
                              controller: _imeiCtrl,
                              focusNode: _imeiFocus,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [_imeiMask],
                              onFieldSubmitted: (String value) {
                                _imeiFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocus);
                              },
                              keyboardType: TextInputType.number,
                              onChanged: (String value) {
                                widget.device.imei = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "IMEI*",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('password'),
                              enabled: enable,
                              controller: _passwordCtrl,
                              focusNode: _passwordFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                _passwordFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_firmwareVersionFocus);
                              },
                              onChanged: (String value) {
                                widget.device.password = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "Senha",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('firmwareVersion'),
                              enabled: enable,
                              controller: _firmwareVersionCtrl,
                              focusNode: _firmwareVersionFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                _firmwareVersionFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_mobileOperatorFocus);
                              },
                              onChanged: (String value) {
                                widget.device.firmwareVersion = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "Versão do firmware",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const FormTitle("Dados do Sim Card"),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('mobileOperator'),
                              enabled: enable,
                              controller: _mobileOperatorCtrl,
                              focusNode: _mobileOperatorFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                _mobileOperatorFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_habilitatedAtFocus);
                              },
                              onChanged: (String value) {
                                widget.device.mobileOperator = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "Operadora",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('habilitatedAt'),
                              enabled: enable,
                              controller: _habilitatedAtCtrl,
                              inputFormatters: [
                                MaskTextInputFormatter(
                                    mask: '##/##/####',
                                    filter: {"#": RegExp(r'[0-9]')})
                              ],
                              focusNode: _habilitatedAtFocus,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.datetime,
                              onFieldSubmitted: (String value) {
                                _habilitatedAtFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_simNumberFocus);
                              },
                              onChanged: (String value) {
                                if (value.length == 10) {
                                  widget.device.habilitatedAt =
                                      dateFromStringDMY(value);
                                }
                                // widget.device?.habilitatedAt = value;
                              },
                              decoration: const InputDecoration(
                                  labelText: "Data da Habilitação*",
                                  hintText: 'DD/MM/AAAA'),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('simNumber'),
                              enabled: enable,
                              controller: _simNumberCtrl,
                              inputFormatters: [_sinCardMask],
                              focusNode: _simNumberFocus,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              onFieldSubmitted: (String value) {
                                _simNumberFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_simPinFocus);
                              },
                              onChanged: (String value) {
                                widget.device.simNumber = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "Sim Card*",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('simPin'),
                              enabled: enable,
                              controller: _simPinCtrl,
                              focusNode: _simPinFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                _simPinFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_simPukFocus);
                              },
                              onChanged: (String value) {
                                widget.device.simPin = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "PIN",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('simPin'),
                              enabled: enable,
                              controller: _simPukCtrl,
                              focusNode: _simPukFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                _simPukFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_simApnFocus);
                              },
                              onChanged: (String value) {
                                widget.device.simPuk = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "PUK",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('simPuk'),
                              enabled: enable,
                              controller: _simApnCtrl,
                              focusNode: _simApnFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                _simApnFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_simApnUserFocus);
                              },
                              onChanged: (String value) {
                                widget.device.simApn = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "APN do Sim Card",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('simApnUser'),
                              enabled: enable,
                              controller: _simApnUserCtrl,
                              focusNode: _simApnUserFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                _simApnUserFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_simApnPasswordFocus);
                              },
                              onChanged: (String value) {
                                widget.device.simApnUser = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "APN - Usuário",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              key: const Key('simApnUser'),
                              enabled: enable,
                              controller: _simApnPasswordCtrl,
                              focusNode: _simApnPasswordFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                _simApnPasswordFocus.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_simIccidFocus);
                              },
                              onChanged: (String value) {
                                widget.device.simApnPassword = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "APN - Senha",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                      SizedBox(
                          width: context.onWideScreen(225, null),
                          child: TextFormField(
                              enabled: enable,
                              controller: _simIccidCtrl,
                              focusNode: _simIccidFocus,
                              onFieldSubmitted: (String value) {
                                _simIccidFocus.unfocus();
                                FocusScope.of(context).requestFocus(_saveFocus);
                              },
                              onChanged: (String value) {
                                widget.device.simIccid = value;
                              },
                              decoration: const InputDecoration(
                                labelText: "ICCID(Código de barras)*",
                              ),
                              validator: (String? value) {
                                return null;
                              })),
                    ],
                  ),
                  const SizedBox(height: 32),
                  !saved
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (widget.formOption ==
                                      EnumFormOption.CREATE) {
                                    await context
                                        .read<DeviceSingleCubit>()
                                        .create(widget.device);
                                  } else if (widget.formOption ==
                                      EnumFormOption.UPDATE) {
                                    await context
                                        .read<DeviceSingleCubit>()
                                        .update(widget.device);
                                  }
                                }
                              },
                              focusNode: _saveFocus,
                              child: SizedBox(
                                width: 138,
                                height: 36,
                                child: Center(
                                    child: Text(
                                        state is DeviceSingleLoadingState
                                            ? 'Salvando..'
                                            : 'Salvar')),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              );
            }),
      ),
    );
  }

  void _listenCubitStates(BuildContext context, DeviceSingleState state) {
    if (state is DeviceSingleErrorState) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialogFails(exception: state.exception));
      _formKey.currentState?.validate();
    }
    if (state is DeviceSingleSuccessfulState) {
      saved = true;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Dispositivo salvo com sucesso!'),
        backgroundColor: Colors.green,
      ));
      _formKey.currentState?.reset();
      Navigator.of(context).pop();
    }
  }
}
