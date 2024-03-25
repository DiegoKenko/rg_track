import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/address.dart';
import 'package:rg_track/model/contact.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/driver.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/drivers/cubit/drivers_cubit.dart';
import 'package:rg_track/ui/drivers/cubit/drivers_state.dart';
import 'package:rg_track/ui/widget/address_form_widget.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/contacts_form_widget.dart';
import 'package:rg_track/ui/widget/customer_form_widget.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/ui/widget/vehicles_form_widget.dart';
import 'package:rg_track/utils/bool_extension.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/date_utils.dart';
import 'package:rg_track/utils/types.dart';
import 'package:rg_track/utils/validator.dart';

class DriverForm extends StatefulWidget {
  final ModelAction<Driver>? onSave;
  final WillPopUpAction<Driver>? willPopUp;
  final bool enable;
  final Driver? driver;

  const DriverForm({
    super.key,
    this.onSave,
    this.willPopUp,
    this.enable = true,
    this.driver,
  });

  @override
  State<DriverForm> createState() => _DriverFormState();
}

class _DriverFormState extends State<DriverForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Driver _driver;
  final TextEditingController _nameCtrl = TextEditingController(),
      _documentCtrl = TextEditingController(),
      _rgCtrl = TextEditingController(),
      _cnhCtrl = TextEditingController(),
      _cnhExpiresAtCtrl = TextEditingController(),
      _cnhFirstEnablementCtrl = TextEditingController(),
      _birthdayCtrl = TextEditingController(),
      _servicePasswordCtrl = TextEditingController(),
      _indicationCtrl = TextEditingController(),
      _phoneCtrl = TextEditingController(),
      _mobilePhoneCtrl = TextEditingController(),
      _emailCtrl = TextEditingController(),
      _secretQuestionCtrl = TextEditingController(),
      _responseCtrl = TextEditingController(),
      _driverCodeCtrl = TextEditingController(),
      _observationsCtrl = TextEditingController(),
      _startWorkAtCtrl = TextEditingController(),
      _endsWorkAtCtrl = TextEditingController(),
      _lunchStartsAtCtrl = TextEditingController(),
      _endLunchAtCtrl = TextEditingController();

  bool _status = true;

  final FocusNode _customerFocus = FocusNode(),
      _nameFocus = FocusNode(),
      _documentFocus = FocusNode(),
      _rgFocus = FocusNode(),
      _genderFocus = FocusNode(),
      _maritalStateFocus = FocusNode(),
      _birthdayFocus = FocusNode(),
      // Habilitação
      _cnhFocus = FocusNode(),
      _cnhExpiresAtFocus = FocusNode(),
      _cnhCategoryFocus = FocusNode(),
      _cnhFirstEnablementFocus = FocusNode(),
      //Address
      _addressesFocus = FocusNode(),
      //Contact
      _contactsFocus = FocusNode(),
      _servicePasswordFocus = FocusNode(),
      _indicationFocus = FocusNode(),
      _phoneFocus = FocusNode(),
      _mobilePhoneFocus = FocusNode(),
      _emailFocus = FocusNode(),
      _secretQuestionFocus = FocusNode(),
      _responseFocus = FocusNode(),
      _driverCodeFocus = FocusNode(),
      _observationsFocus = FocusNode(),
      _startWorkAtFocus = FocusNode(),
      _endsWorkAtFocus = FocusNode(),
      _lunchStartsAtFocus = FocusNode(),
      _endLunchAtFocus = FocusNode(),
      _saveFocus = FocusNode(),
      _vehicleFocus = FocusNode();

  final MaskTextInputFormatter _firstEnablementMask =
      MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'\d')});
  final MaskTextInputFormatter _cnhExpiresAtMask =
      MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'\d')});
  final MaskTextInputFormatter _birthdayMask =
      MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'\d')});

  final ValueNotifier<Customer?> _customerNotifier =
      ValueNotifier<Customer?>(null);

  @override
  void initState() {
    _loadDriver(widget.driver ?? Driver());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onWillPop: () async {
        return await widget.willPopUp?.call(_driver) ?? true;
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
            CustomerFormWidget(
              focus: _customerFocus,
              nextFocus: _nameFocus,
              enable: widget.enable,
              onSelect: (Customer? customer) {
                _driver.customer = customer;
                _driver.customerId = customer?.id;
                _customerNotifier.value = customer;
                FocusScope.of(context).requestFocus(_nameFocus);
              },
              customers: const [],
            ),
            const FormTitle('Dados pessoais'),
            Wrap(spacing: 16, runSpacing: 16, children: [
              SizedBox(
                width: context.onWideScreen(466, null),
                child: TextFormField(
                  controller: _nameCtrl,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_documentFocus);
                  },
                  focusNode: _nameFocus,
                  validator: (String? value) {
                    return Validator(value).isRequired.isName();
                  },
                  onChanged: (String value) {
                    _driver.name = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Nome Completo",
                    enabled: widget.enable,
                  ),
                ),
              ),
              SizedBox(
                width: context.onWideScreen(225, null),
                child: TextFormField(
                  controller: _documentCtrl,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_rgFocus);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: _documentFocus,
                  inputFormatters: [
                    MaskTextInputFormatter(
                        mask: '###.###.###-##', filter: {"#": RegExp(r'\d')})
                  ],
                  validator: (String? value) {
                    return Validator(value).isRequired.isCpfValid();
                  },
                  onChanged: (String value) {
                    _driver.document = value;
                  },
                  decoration: InputDecoration(
                    labelText: "CPF",
                    enabled: widget.enable,
                  ),
                ),
              ),
              SizedBox(
                width: context.onWideScreen(225, null),
                child: TextFormField(
                  controller: _rgCtrl,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_genderFocus);
                  },
                  focusNode: _rgFocus,
                  validator: (String? value) {
                    return Validator(value).isRequired();
                  },
                  onChanged: (String value) {
                    _driver.rg = value;
                  },
                  decoration: InputDecoration(
                    labelText: "RG",
                    enabled: widget.enable,
                  ),
                ),
              ),
              SizedBox(
                width: context.onWideScreen(225, null),
                child: DropdownButtonFormField<String>(
                  // value: _driver.gender,
                  hint: const Text('Sexo'),
                  onChanged: (String? gender) => setState(() {
                    _driver.gender = gender;
                    FocusScope.of(context).requestFocus(_maritalStateFocus);
                  }),
                  focusNode: _genderFocus,
                  validator: (String? value) {
                    return Validator(value).isRequired();
                  },
                  decoration: InputDecoration(enabled: widget.enable),
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'male',
                      child: Text('Masculino'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'female',
                      child: Text('Feminino'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'other'
                          'male',
                      child: Text('Outro'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                //single,married,divorced,widower,separate
                width: context.onWideScreen(225, null),
                child: DropdownButtonFormField<String>(
                  // value: _driver.gender,
                  hint: const Text('Estado Civil'),
                  onChanged: (String? maritalState) => setState(() {
                    _driver.maritalState = maritalState;
                    FocusScope.of(context).requestFocus(_birthdayFocus);
                  }),
                  decoration: InputDecoration(enabled: widget.enable),
                  focusNode: _maritalStateFocus,
                  validator: (String? value) => Validator(value).isRequired(),
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'single',
                      child: Text('Solteiro'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'married',
                      child: Text('Casado'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'divorced',
                      child: Text('Divorciado'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'widower',
                      child: Text('Viúvo'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'separated',
                      child: Text('Separado'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: context.onWideScreen(225, null),
                  child: TextFormField(
                    enabled: widget.enable,
                    controller: _birthdayCtrl,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_cnhFocus);
                    },
                    focusNode: _birthdayFocus,
                    inputFormatters: [_birthdayMask],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    onChanged: (String value) {
                      if (value.length == 10) {
                        _driver.birthday = dateFromStringDMY(value);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Nascimento",
                        hintText: 'DD/MM/AAAA',
                        suffixIcon: IconButton(
                          icon: Icon(MdiIcons.calendar),
                          onPressed: () {
                            showDatePicker(
                                    helpText: 'Nascimento',
                                    firstDate: DateTime(1900),
                                    initialDate: DateTime.now()
                                        .add(const Duration(days: -6570)),
                                    lastDate: DateTime.now(),
                                    context: context)
                                .then((DateTime? value) {
                              if (value != null) {
                                _driver.birthday = value;
                                _birthdayCtrl.text = formatDataDMY(value) ?? '';
                              }
                            });
                          },
                        )),
                    validator: (String? value) =>
                        Validator(value).isRequired.isDateDMY(),
                  )),
              SizedBox(
                width: context.onWideScreen(225, null),
                child: SwitchListTile(
                  title: const Text('Status'),
                  value: _status,
                  onChanged: (bool value) {
                    if (widget.enable.not) return;
                    _status = !_status;
                    _driver.status = _status ? 'active' : 'inactive';
                    setState(() {});
                  },
                ),
              )
            ]),
            const FormTitle('Habilitação'),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: context.onWideScreen(225, null),
                  child: TextFormField(
                    controller: _cnhCtrl,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_cnhCategoryFocus);
                    },
                    focusNode: _cnhFocus,
                    onChanged: (String value) {
                      _driver.cnh = value;
                    },
                    validator: (String? value) {
                      return Validator(value).isRequired();
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "CNH",
                      enabled: widget.enable,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.onWideScreen(225, null),
                  child: DropdownButtonFormField<String>(
                    items: ['A', 'AB', 'AC', 'AD', 'AE', 'B', 'C', 'D', 'E']
                        .map((String e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      enabled: widget.enable,
                      label: const Text('Categoria'),
                    ),
                    focusNode: _cnhCategoryFocus,
                    onChanged: (String? value) {
                      _driver.cnhCategory = value;
                      FocusScope.of(context)
                          .requestFocus(_cnhFirstEnablementFocus);
                    },
                    validator: (String? value) => Validator(value).isRequired(),
                  ),
                ),
                SizedBox(
                  width: context.onWideScreen(225, null),
                  child: TextFormField(
                    enabled: widget.enable,
                    controller: _cnhFirstEnablementCtrl,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_cnhExpiresAtFocus);
                    },
                    focusNode: _cnhFirstEnablementFocus,
                    inputFormatters: [_firstEnablementMask],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    onChanged: (String value) {
                      if (value.length == 10) {
                        _driver.cnhFirstEnablement = dateFromStringDMY(value);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "1° Habilitação",
                        hintText: 'DD/MM/AAAA',
                        enabled: widget.enable,
                        suffixIcon: IconButton(
                          icon: Icon(MdiIcons.calendar),
                          onPressed: () {
                            showDatePicker(
                                    helpText: '1° Habilitação',
                                    firstDate: DateTime(1900),
                                    initialDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 6570)),
                                    context: context)
                                .then((DateTime? value) {
                              if (value != null) {
                                _driver.cnhExpiresAt = value;
                                _cnhExpiresAtCtrl.text =
                                    formatDataDMY(value) ?? '';
                              }
                            });
                          },
                        )),
                    validator: (String? value) =>
                        Validator(value).isRequired.isDateDMY(),
                  ),
                ),
                SizedBox(
                  width: context.onWideScreen(225, null),
                  child: TextFormField(
                    enabled: widget.enable,
                    controller: _cnhExpiresAtCtrl,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_addressesFocus);
                    },
                    focusNode: _cnhExpiresAtFocus,
                    inputFormatters: [_cnhExpiresAtMask],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    onChanged: (String value) {
                      if (value.length == 10) {
                        _driver.cnhExpiresAt = dateFromStringDMY(value);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Vencimento CNH",
                        hintText: 'DD/MM/AAAA',
                        enabled: widget.enable,
                        suffixIcon: IconButton(
                          icon: Icon(MdiIcons.calendar),
                          onPressed: () {
                            showDatePicker(
                                    helpText: 'Vencimento CNH',
                                    firstDate: DateTime(1900),
                                    initialDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 6570)),
                                    context: context)
                                .then((DateTime? value) {
                              if (value != null) {
                                _driver.cnhExpiresAt = value;
                                _cnhExpiresAtCtrl.text =
                                    formatDataDMY(value) ?? '';
                              }
                            });
                          },
                        )),
                    validator: (String? value) =>
                        Validator(value).isRequired.isDateDMY(),
                  ),
                ),
              ],
            ),
            AddressFormWidget(
              focus: _addressesFocus,
              nextFocus: _contactsFocus,
              onChange: (Address model) {
                _driver.addresses = [model];
              },
              enable: widget.enable,
            ),
            ContactsFormWidget(
              focusNode: _contactsFocus,
              nextFocus: _servicePasswordFocus,
              contacts: _driver.contacts,
              enable: widget.enable,
              onChange: (List<Contact> contacts) => _driver.contacts = contacts,
            ),
            const FormTitle('Dados complementares'),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: _servicePasswordCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_indicationFocus);
                      },
                      focusNode: _servicePasswordFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        _driver.servicePassword = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Senha de atendimento",
                      ),
                    )),
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: _indicationCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneFocus);
                      },
                      focusNode: _indicationFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        _driver.indication = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Indicação",
                      ),
                    )),
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: _phoneCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_mobilePhoneFocus);
                      },
                      focusNode: _phoneFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        _driver.phone = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Telefone",
                      ),
                    )),
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: _mobilePhoneCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocus);
                      },
                      focusNode: _mobilePhoneFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        _driver.mobilePhone = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Celular",
                      ),
                    )),
                SizedBox(
                  width: context.onWideScreen(225, null),
                  child: SwitchListTile(
                    title: const Text('É WhatsApp?'),
                    value: _driver.isWhatsapp ?? false,
                    onChanged: (bool value) {
                      if (widget.enable.not) return;
                      _driver.isWhatsapp = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: _emailCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_secretQuestionFocus);
                      },
                      focusNode: _emailFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        _driver.email = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                    )),
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: _secretQuestionCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_responseFocus);
                      },
                      focusNode: _secretQuestionFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        _driver.secretQuestion = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Pergunta de segurança",
                      ),
                    )),
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: _responseCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_driverCodeFocus);
                      },
                      focusNode: _responseFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        _driver.secretAnswer = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Resposta",
                      ),
                    )),
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: _driverCodeCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_observationsFocus);
                      },
                      focusNode: _driverCodeFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        _driver.driverCode = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Codigo Motorista",
                      ),
                    )),
                TextFormField(
                  enabled: widget.enable,
                  controller: _observationsCtrl,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_startWorkAtFocus);
                  },
                  focusNode: _observationsFocus,
                  textInputAction: TextInputAction.next,
                  onChanged: (String value) {
                    _driver.observations = value;
                  },
                  minLines: 5,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: "Observações / Procedimentos",
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
            const FormTitle('Jornada'),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: widget.enable,
                      controller: _startWorkAtCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_endsWorkAtFocus);
                      },
                      focusNode: _startWorkAtFocus,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '##:##', filter: {"#": RegExp(r'\d')})
                      ],
                      onChanged: (String value) {
                        _driver.startsWorkAt = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Início da Jornada",
                        hintText: '08:00',
                        suffixIcon: IconButton(
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime:
                                        const TimeOfDay(hour: 8, minute: 0))
                                .then((TimeOfDay? value) {
                              if (value != null) {
                                _startWorkAtCtrl.text = value.format(context);
                                _driver.startsWorkAt = value.format(context);
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
                            .requestFocus(_lunchStartsAtFocus);
                      },
                      focusNode: _endsWorkAtFocus,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '##:##', filter: {"#": RegExp(r'\d')})
                      ],
                      onChanged: (String value) {
                        _driver.endsWorkAt = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Termino da Jornada",
                        hintText: '18:00',
                        suffixIcon: IconButton(
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime:
                                        const TimeOfDay(hour: 18, minute: 0))
                                .then((TimeOfDay? value) {
                              if (value != null) {
                                _endsWorkAtCtrl.text = value.format(context);
                                _driver.endsWorkAt = value.format(context);
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
                      controller: _lunchStartsAtCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_endLunchAtFocus);
                      },
                      focusNode: _lunchStartsAtFocus,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '##:##', filter: {"#": RegExp(r'\d')})
                      ],
                      onChanged: (String value) {
                        _driver.lunchStartsAt = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Saída para Almoço",
                        hintText: '11:00',
                        suffixIcon: IconButton(
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime:
                                        const TimeOfDay(hour: 11, minute: 0))
                                .then((TimeOfDay? value) {
                              if (value != null) {
                                _lunchStartsAtCtrl.text = value.format(context);
                                _driver.lunchStartsAt = value.format(context);
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
                      controller: _endLunchAtCtrl,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_vehicleFocus);
                      },
                      focusNode: _endLunchAtFocus,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '##:##', filter: {"#": RegExp(r'\d')})
                      ],
                      onChanged: (String value) {
                        _driver.lunchStopsAt = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Retorno do almoço",
                        hintText: '12:00',
                        suffixIcon: IconButton(
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime:
                                        const TimeOfDay(hour: 12, minute: 30))
                                .then((TimeOfDay? value) {
                              if (value != null) {
                                _endLunchAtCtrl.text = value.format(context);
                                _driver.endsWorkAt = value.format(context);
                              }
                            });
                          },
                          icon: Icon(MdiIcons.clockOutline),
                        ),
                      ),
                    )),
              ],
            ),
            ValueListenableBuilder<Customer?>(
              valueListenable: _customerNotifier,
              builder: (BuildContext context, Customer? customer, _) =>
                  VehiclesFormWidget(
                enable: widget.enable,
                customer: customer,
                onChange: (List<Vehicle> model) {
                  print(model);
                },
              ),
            ),
            const SizedBox(height: 32),
            if (widget.enable)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<DriversCubit, DriversState>(
                    listener: _listenCubitStates,
                    builder: (BuildContext context, DriversState state) =>
                        ElevatedButton(
                      onPressed: state is DriversStoreProcessingState
                          ? () {}
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context
                                    .read<DriversCubit>()
                                    .storeDriver(_driver);
                              }
                            },
                      focusNode: _saveFocus,
                      child: SizedBox(
                        width: context.onWideScreen(138, null),
                        height: 36,
                        child: Center(
                            child: Text(state is DriversStoreProcessingState
                                ? 'Salvando..'
                                : 'Salvar')),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  void _listenCubitStates(BuildContext context, DriversState state) {
    if (state is DriverStoredFailsState) {
      // _errors = state;
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialogFails(exception: state.exception));
      _formKey.currentState?.validate();
    }
    if (state is DriverStoredSuccessfulState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Equipamento salvo com sucesso!'),
        backgroundColor: Colors.green,
      ));
      _formKey.currentState?.reset();
    }

    if (state is DriverLoadByIdState) {
      // _loadDriverForm(state.driver);
      setState(() {});
    }
  }

  void _loadDriver(Driver driver) {
    _driver = driver;
    _nameCtrl.text = driver.name ?? '';
    _documentCtrl.text = driver.document ?? '';
    _rgCtrl.text = driver.rg ?? '';
    _cnhCtrl.text = driver.cnh ?? '';
    // _cnhExpiresAtCtrl.text = driver.cnhExpiresAt ?? '';
    // _cnhFirstEnablementCtrl.text = driver.cnhFirstEnablement ?? '';
    // _birthdayCtrl.text = driver.birthday ?? '';
    _servicePasswordCtrl.text = driver.servicePassword ?? '';
    _indicationCtrl.text = driver.indication ?? '';
    _phoneCtrl.text = driver.phone ?? '';
    _mobilePhoneCtrl.text = driver.mobilePhone ?? '';
    _emailCtrl.text = driver.email ?? '';
    _secretQuestionCtrl.text = driver.secretQuestion ?? '';
    // _responseCtrl.text = driver.response ?? '';
    _driverCodeCtrl.text = driver.driverCode ?? '';
    _observationsCtrl.text = driver.observations ?? '';
    // _startWorkAtCtrl.text = driver.startWorkAt ?? '';
    _endsWorkAtCtrl.text = driver.endsWorkAt ?? '';
    _lunchStartsAtCtrl.text = driver.lunchStartsAt ?? '';
    // _endLunchAtCtrl.text = driver.endLunchAt ?? '';
  }
}
