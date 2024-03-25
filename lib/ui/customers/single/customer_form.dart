import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/address.dart';
import 'package:rg_track/model/contact.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/customers/single/cubit/customer_single_cubit.dart';
import 'package:rg_track/ui/customers/single/cubit/customer_single_state.dart';
import 'package:rg_track/ui/customers/widget/customer_cnpj_form.dart';
import 'package:rg_track/ui/customers/widget/customer_cpf_form.dart';
import 'package:rg_track/ui/widget/address_form_widget.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/contacts_form_widget.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/currency_mask.dart';
import 'package:rg_track/utils/mask_text_input_formatter_extension.dart';
import 'package:rg_track/utils/validator.dart';

class CustomerForm extends StatefulWidget {
  final EnumFormOption formOption;
  final Customer customer;

  const CustomerForm({
    Key? key,
    required this.formOption,
    required this.customer,
  }) : super(key: key);

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<Customer?> _subClientNotifier = ValueNotifier(null);

  final TextEditingController _documentCtrl = TextEditingController(),
      _priceCtrl = CurrencyTextInputMaskController(),
      _nameCtrl = TextEditingController(),
      _phoneCtrl = TextEditingController(),
      _emailCtrl = TextEditingController(),
      _contractInitiatedAtCtrl = TextEditingController(),
      _contractEndsAtCtrl = TextEditingController(),
      _dueDateCtrl = TextEditingController(),
      _birthdayCtrl = TextEditingController(),
      _stateRegistrationCtrl = TextEditingController(),
      _socialNameCtrl = TextEditingController(),
      _fantasyNameCtrl = TextEditingController();

  final FocusNode _documentFocus = FocusNode(),
      _nameFocus = FocusNode(),
      _saveFocus = FocusNode(),
      _addressesFocus = FocusNode(),
      _contactsFocus = FocusNode(),
      _servicePasswordFocus = FocusNode(),
      _priceFocus = FocusNode(),
      _phoneFocus = FocusNode(),
      _mobilePhoneFocus = FocusNode(),
      _emailFocus = FocusNode(),
      _contractInitiatedAtFocus = FocusNode(),
      _contractEndsAtFocus = FocusNode(),
      _dueDateFocus = FocusNode(),
      _birthdayFocus = FocusNode(),
      _genderFocus = FocusNode(),
      _maritalStateFocus = FocusNode(),
      _stateRegistrationFocus = FocusNode(),
      _socialNameFocus = FocusNode(),
      _fantasyNameFocus = FocusNode(),
      _subClientFocus = FocusNode();

  final MaskTextInputFormatter _maskCPF = MaskTextInputFormatter(
      mask: '###.###.###-###', filter: {"#": RegExp(r'\d')});

  bool _showCPF = true;

  @override
  void initState() {
    _subClientNotifier.value = widget.customer.customerParent;
    _loadCustomerForm();
    super.initState();
  }

  bool get enable {
    return !(widget.formOption == EnumFormOption.VIEW);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
            const SizedBox(
              height: 16,
            ),
            const FormTitle('Dados do cliente'),
            const SizedBox(
              height: 16,
            ),
            Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.onWideScreen(300, null),
                    child: TextFormField(
                      enabled: enable,
                      controller: _documentCtrl,
                      focusNode: _documentFocus,
                      inputFormatters: [_maskCPF],
                      onFieldSubmitted: (_) {
                        _nameFocus.requestFocus();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        return Validator(value).isRequired.isCpfOrCnpjValid();
                      },
                      onChanged: (String value) {
                        widget.customer.document = value;
                        _updateUiByTypeUser(value);
                      },
                      decoration: InputDecoration(
                        labelText: "CPF / CNPJ",
                        enabled: enable,
                      ),
                    ),
                  ),
                ]),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              firstChild: Visibility(
                visible: _showCPF,
                child: CustomerCpfForm(
                  customer: widget.customer,
                  enable: enable,
                  birthdayCtrl: _birthdayCtrl,
                  birthdayFocus: _birthdayFocus,
                  maritalStateFocus: _maritalStateFocus,
                  cpfCtrl: _documentCtrl,
                  cpfFocus: _documentFocus,
                  nameCtrl: _nameCtrl,
                  nameFocus: _nameFocus,
                  genderFocus: _genderFocus,
                  nextFocus: _addressesFocus,
                ),
              ),
              secondChild: Visibility(
                visible: !_showCPF,
                child: CustomerCnpjForm(
                  enable: enable,
                  customer: widget.customer,
                  socialNameCtrl: _socialNameCtrl,
                  socialNameFocus: _socialNameFocus,
                  fantasyNameCtrl: _fantasyNameCtrl,
                  fantasyNameFocus: _fantasyNameFocus,
                  birthdayCtrl: _birthdayCtrl,
                  birthdayFocus: _birthdayFocus,
                  stateRegistrationCtrl: _stateRegistrationCtrl,
                  stateRegistrationFocus: _stateRegistrationFocus,
                  nextFocus: _subClientFocus,
                ),
              ),
              crossFadeState: _showCPF
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            const SizedBox(height: 16),
            const FormTitle('Subcliente de:'),
            FutureBuilder(
                future: context
                    .read<CustomerSingleCubit>()
                    .getSubCustomerAllowed(
                        AuthService.instance.user.id ?? '', widget.customer),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    width: context.onWideScreen(225, null),
                    child: ValueListenableBuilder(
                        valueListenable: _subClientNotifier,
                        builder: (context, value, _) {
                          return IgnorePointer(
                            ignoring: !enable,
                            child: DropdownButtonFormField<Customer>(
                              value: value,
                              hint: const Text('Cliente principal'),
                              onChanged: (Customer? c) {
                                if (c != null) {
                                  widget.customer.customerParent = c;
                                  _subClientNotifier.value = c;
                                }
                                _addressesFocus.requestFocus();
                              },
                              focusNode: _subClientFocus,
                              decoration: InputDecoration(enabled: enable),
                              items: snap.data!.map<DropdownMenuItem<Customer>>(
                                  (Customer c) {
                                return DropdownMenuItem<Customer>(
                                  value: c,
                                  child: Text(c.fullName ?? ''),
                                );
                              }).toList(),
                            ),
                          );
                        }),
                  );
                }),
            const SizedBox(height: 16),
            AddressFormWidget(
              focus: _addressesFocus,
              nextFocus: _contactsFocus,
              address: null,
              onChange: (Address model) {},
              enable: enable,
            ),
            const SizedBox(height: 32),
            ContactsFormWidget(
              focusNode: _contactsFocus,
              nextFocus: _mobilePhoneFocus,
              contacts: widget.customer.contacts ?? [],
              enable: enable,
              onChange: (List<Contact> contacts) =>
                  widget.customer.contacts = contacts,
            ),
            const SizedBox(height: 32),
            const FormTitle('Dados complementares'),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: enable,
                      controller: _phoneCtrl,
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '+## (##) ####-####',
                            filter: {"#": RegExp(r'\d')})
                      ],
                      onFieldSubmitted: (_) {
                        _mobilePhoneFocus.requestFocus();
                      },
                      focusNode: _phoneFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        widget.customer.phone = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Telefone",
                      ),
                    )),
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      enabled: enable,
                      controller: _emailCtrl,
                      onFieldSubmitted: (_) {
                        _servicePasswordFocus.requestFocus();
                      },
                      focusNode: _emailFocus,
                      textInputAction: TextInputAction.next,
                      onChanged: (String value) {
                        widget.customer.email = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 16),
            const FormTitle('Plano de pagamento'),
            const SizedBox(height: 16),
            SizedBox(
              width: context.onWideScreen(225, null),
              child: TextFormField(
                controller: _priceCtrl,
                focusNode: _priceFocus,
                enabled: enable,
                onFieldSubmitted: (_) =>
                    _contractInitiatedAtFocus.requestFocus(),
                decoration: const InputDecoration(
                  labelText: "Valor por veículo (R\$)",
                ),
                onChanged: (String value) {
                  /*   widget.customer.customerPlan!.priceVehicleCents =
                      int.tryParse(value.replaceAll(RegExp(r'\D'), '')); */
                },
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: context.onWideScreen(225, null),
                  child: TextFormField(
                    enabled: enable,
                    controller: _contractInitiatedAtCtrl,
                    onFieldSubmitted: (_) {
                      _contractEndsAtFocus.requestFocus();
                    },
                    focusNode: _contractInitiatedAtFocus,
                    inputFormatters: [
                      MaskTextInputFormatter(
                          mask: '##/##/####', filter: {"#": RegExp(r'\d')})
                    ],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    onChanged: (String value) {
                      if (value.length == 10) {}
                    },
                    decoration: InputDecoration(
                        labelText: "Data inicial contratual",
                        hintText: 'DD/MM/AAAA',
                        enabled: enable,
                        suffixIcon: IconButton(
                          icon: Icon(MdiIcons.calendar),
                          onPressed: () {
                            showDatePicker(
                                    helpText: 'Data inicial contratual',
                                    firstDate: DateTime(2019),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime(3000),
                                    context: context)
                                .then((DateTime? value) {
                              if (value != null) {}
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
                    enabled: enable,
                    controller: _contractEndsAtCtrl,
                    onFieldSubmitted: (_) {
                      _dueDateFocus.requestFocus();
                    },
                    focusNode: _contractEndsAtFocus,
                    inputFormatters: [
                      MaskTextInputFormatter(
                          mask: '##/##/####', filter: {"#": RegExp(r'\d')})
                    ],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    onChanged: (String value) {
                      if (value.length == 10) {}
                    },
                    decoration: InputDecoration(
                        labelText: "Data final contratual",
                        hintText: 'DD/MM/AAAA',
                        enabled: enable,
                        suffixIcon: IconButton(
                          icon: Icon(MdiIcons.calendar),
                          onPressed: () {
                            showDatePicker(
                                    helpText: 'Data final contratual',
                                    firstDate: DateTime(1900),
                                    initialDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 6570)),
                                    context: context)
                                .then((DateTime? value) {
                              if (value != null) {}
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
                    enabled: enable,
                    controller: _dueDateCtrl,
                    onFieldSubmitted: (_) {
                      _saveFocus.requestFocus();
                    },
                    focusNode: _dueDateFocus,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) =>
                        Validator(value).isRequired.min(1).max(28)(),
                    onChanged: (String value) {
                      /*   widget.customer.customerPlan?.dueDay =
                          int.tryParse(value); */
                    },
                    decoration: const InputDecoration(
                      labelText: "Dia de vencimento",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (enable)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<CustomerSingleCubit, CustomerSingleState>(
                    listener: _listenCubitStates,
                    builder:
                        (BuildContext context, CustomerSingleState state) =>
                            ElevatedButton(
                      onPressed: state is CustomerSingleLoadingState
                          ? () {}
                          : () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (widget.formOption ==
                                    EnumFormOption.CREATE) {
                                  await context
                                      .read<CustomerSingleCubit>()
                                      .create(widget.customer);
                                } else if (widget.formOption ==
                                    EnumFormOption.UPDATE) {
                                  await context
                                      .read<CustomerSingleCubit>()
                                      .update(widget.customer);
                                }
                              }
                            },
                      focusNode: _saveFocus,
                      child: SizedBox(
                        width: context.onWideScreen(138, null),
                        height: 36,
                        child: Center(
                            child: Text(state is CustomerSingleLoadingState
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

  void _updateUiByTypeUser(String document) {
    if (document.length == 14) {
      _showCPF = true;
      _documentCtrl.text = _maskCPF.updateMask(mask: "###.###.###-###").text;
      _documentCtrl.selection = TextSelection.fromPosition(
          TextPosition(offset: _documentCtrl.text.length));

      setState(() {});
    } else if (document.length > 14) {
      _showCPF = false;
      _documentCtrl.text = _maskCPF.updateMask(mask: "##.###.###/####-##").text;
      _documentCtrl.selection = TextSelection.fromPosition(
          TextPosition(offset: _documentCtrl.text.length));

      setState(() {});
    }
  }

  void _listenCubitStates(BuildContext context, CustomerSingleState state) {
    if (state is CustomerSingleErrorState) {
      // _errors = state;
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialogFails(exception: state.exception));
      _formKey.currentState?.validate();
    }
    if (state is CustomerSingleSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cliente salvo com sucesso!'),
        backgroundColor: Colors.green,
      ));
      _formKey.currentState?.reset();
      Navigator.of(context).pop();
    }
  }

  void _loadCustomerForm() {
    _maskCPF.setText(_documentCtrl, widget.customer.document);
    _nameCtrl.text = widget.customer.fullName ?? '';
    _fantasyNameCtrl.text = widget.customer.fantasyName ?? '';
    _socialNameCtrl.text = widget.customer.socialName ?? '';
    _phoneCtrl.text = widget.customer.phone ?? '';
    _emailCtrl.text = widget.customer.email ?? '';

    _updateUiByTypeUser(widget.customer.document ?? '');
  }
}
