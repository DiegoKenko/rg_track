import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/validator.dart';

class CustomerCnpjForm extends StatelessWidget {
  final Customer customer;
  final bool enable;
  final TextEditingController socialNameCtrl,
      fantasyNameCtrl,
      stateRegistrationCtrl,
      birthdayCtrl;
  final FocusNode socialNameFocus,
      fantasyNameFocus,
      stateRegistrationFocus,
      birthdayFocus,
      nextFocus;

  const CustomerCnpjForm({
    super.key,
    required this.customer,
    required this.enable,
    required this.socialNameCtrl,
    required this.socialNameFocus,
    required this.fantasyNameCtrl,
    required this.fantasyNameFocus,
    required this.stateRegistrationCtrl,
    required this.stateRegistrationFocus,
    required this.birthdayCtrl,
    required this.birthdayFocus,
    required this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('customer_cnpj'),
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
                  enabled: enable,
                  controller: socialNameCtrl,
                  onFieldSubmitted: (_) {
                    fantasyNameFocus.requestFocus();
                  },
                  focusNode: socialNameFocus,
                  textInputAction: TextInputAction.next,
                  onChanged: (String value) {
                    customer.socialName = value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Razão Social",
                  ),
                )),
            SizedBox(
                width: context.onWideScreen(225, null),
                child: TextFormField(
                  enabled: enable,
                  controller: fantasyNameCtrl,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(birthdayFocus);
                  },
                  focusNode: fantasyNameFocus,
                  textInputAction: TextInputAction.next,
                  onChanged: (String value) {
                    customer.fantasyName = value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Nome Fantasia",
                  ),
                )),
            SizedBox(
                width: context.onWideScreen(225, null),
                child: TextFormField(
                  enabled: enable,
                  controller: stateRegistrationCtrl,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(birthdayFocus);
                  },
                  focusNode: stateRegistrationFocus,
                  textInputAction: TextInputAction.next,
                  onChanged: (String value) {},
                  decoration: const InputDecoration(
                    labelText: "Inscrição Estadual",
                  ),
                )),
            SizedBox(
                width: context.onWideScreen(225, null),
                child: TextFormField(
                  enabled: enable,
                  controller: birthdayCtrl,
                  focusNode: birthdayFocus,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(nextFocus);
                  },
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
                      labelText: "Constituição da Empresa",
                      hintText: 'DD/MM/AAAA',
                      suffixIcon: IconButton(
                        icon: Icon(MdiIcons.calendar),
                        onPressed: () {
                          showDatePicker(
                                  helpText: 'Constituição da Empresa',
                                  firstDate: DateTime(1900),
                                  initialDate: DateTime.now()
                                      .add(const Duration(days: -6570)),
                                  lastDate: DateTime.now(),
                                  context: context)
                              .then((DateTime? value) {
                            if (value != null) {}
                          });
                        },
                      )),
                  validator: (String? value) =>
                      Validator(value).isRequired.isDateDMY(),
                )),
          ],
        ),
      ],
    );
  }
}
