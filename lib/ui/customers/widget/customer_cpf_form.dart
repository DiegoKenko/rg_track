import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/validator.dart';

class CustomerCpfForm extends StatefulWidget {
  final bool enable;
  final Customer customer;
  final TextEditingController nameCtrl, cpfCtrl, birthdayCtrl;
  final FocusNode nameFocus,
      cpfFocus,
      birthdayFocus,
      genderFocus,
      maritalStateFocus,
      nextFocus;

  const CustomerCpfForm({
    super.key,
    required this.customer,
    required this.enable,
    required this.nameCtrl,
    required this.cpfCtrl,
    required this.birthdayCtrl,
    required this.nameFocus,
    required this.cpfFocus,
    required this.birthdayFocus,
    required this.genderFocus,
    required this.maritalStateFocus,
    required this.nextFocus,
  });

  @override
  State<CustomerCpfForm> createState() => _CustomerCpfFormState();
}

class _CustomerCpfFormState extends State<CustomerCpfForm> {
  final ValueNotifier<String?> _genderNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _maritalStateNotifier =
      ValueNotifier<String?>(null);

  @override
  void initState() {
    _setCustomer(widget.customer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('customer_cpf'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
                width: context.onWideScreen(225, null),
                child: TextFormField(
                  enabled: widget.enable,
                  controller: widget.nameCtrl,
                  onFieldSubmitted: (_) {
                    widget.birthdayFocus.requestFocus();
                  },
                  focusNode: widget.nameFocus,
                  textInputAction: TextInputAction.next,
                  onChanged: (String value) {
                    widget.customer.fullName = value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Nome Completo",
                  ),
                )),
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
                  controller: widget.birthdayCtrl,
                  focusNode: widget.birthdayFocus,
                  onFieldSubmitted: (_) {
                    widget.genderFocus.requestFocus();
                  },
                  inputFormatters: [
                    MaskTextInputFormatter(
                        mask: '##/##/####', filter: {"#": RegExp(r'\d')})
                  ],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  onChanged: (String value) {
                    if (value.length == 10) {
                      widget.customer.birthday = DateTime.parse(value);
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
                              widget.customer.birthday = value;
                            }
                          });
                        },
                      )),
                  validator: (String? value) =>
                      Validator(value).isRequired.isDateDMY(),
                )),
            SizedBox(
              width: context.onWideScreen(225, null),
              child: ValueListenableBuilder<String?>(
                valueListenable: _genderNotifier,
                builder: (BuildContext context, String? value, _) {
                  return IgnorePointer(
                    ignoring: !widget.enable,
                    child: DropdownButtonFormField<String>(
                      value: value,
                      hint: const Text('Sexo'),
                      onChanged: (String? gender) {
                        widget.customer.gender = gender;
                        _genderNotifier.value = gender;
                        widget.maritalStateFocus.requestFocus();
                      },
                      focusNode: widget.genderFocus,
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
                  );
                },
              ),
            ),
            SizedBox(
              //single,married,divorced,widower,separate
              width: context.onWideScreen(225, null),
              child: ValueListenableBuilder<String?>(
                valueListenable: _maritalStateNotifier,
                builder: (BuildContext context, String? value, __) =>
                    IgnorePointer(
                  ignoring: !widget.enable,
                  child: DropdownButtonFormField<String>(
                    value: _maritalStateNotifier.value,
                    hint: const Text('Estado Civil'),
                    onChanged: (String? maritalState) {
                      widget.nextFocus.requestFocus();
                    },
                    decoration: InputDecoration(enabled: widget.enable),
                    focusNode: widget.maritalStateFocus,
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
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _setCustomer(Customer customer) {
    _genderNotifier.value = customer.gender;
  }
}
