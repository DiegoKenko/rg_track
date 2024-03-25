import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/contact.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/types.dart';
import 'package:rg_track/utils/validator.dart';

class ContactsFormWidget extends StatefulWidget {
  final bool enable, canEmpty;
  final List<Contact> contacts;
  final ModelAction<List<Contact>>? onChange;
  final FocusNode? focusNode, nextFocus;

  const ContactsFormWidget({
    Key? key,
    required this.contacts,
    this.enable = true,
    this.canEmpty = true,
    this.onChange,
    this.focusNode,
    this.nextFocus,
  }) : super(key: key);

  @override
  State<ContactsFormWidget> createState() => _ContactsFormWidgetState();
}

class _ContactsFormWidgetState extends State<ContactsFormWidget> {
  List<Contact> _contacts = [
    Contact(email: '', phone: '', contactName: ''),
  ];

  @override
  void initState() {
    if (widget.contacts.isNotEmpty) _contacts = widget.contacts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormTitle('Contatos'),
        ..._contacts.map(_makeModel).toList(),
        Visibility(
          visible: widget.enable,
          child: Opacity(
              opacity: 0.5,
              child: _makeModel(
                  Contact(email: '', phone: '', contactName: ''),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    height: 48,
                    width: 48,
                    child: IconButton(
                        onPressed: () {
                          _contacts.add(
                              Contact(email: '', phone: '', contactName: ''));
                          widget.onChange?.call(_contacts);
                          setState(() {});
                        },
                        icon: SizedBox(
                          child: Icon(
                            MdiIcons.plus,
                            color: Colors.white,
                            size: 32,
                          ),
                        )),
                  ),
                  true)),
        ),
      ],
    );
  }

  Widget _makeModel(
    Contact contact, [
    Widget? button,
    bool skipValidation = false,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          SizedBox(
            width: context.onWideScreen(225, null),
            child: TextFormField(
              validator: skipValidation
                  ? null
                  : (String? value) {
                      return Validator(value).isRequired();
                    },
              onChanged: (String value) {
                contact.contactName = value;
                widget.onChange?.call(_contacts);
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Nome",
                enabled: !skipValidation && widget.enable,
              ),
            ),
          ),
          SizedBox(
            width: context.onWideScreen(225, null),
            child: TextFormField(
              validator: skipValidation
                  ? null
                  : (String? value) {
                      return Validator(value).isEmailValid();
                    },
              onChanged: (String value) {
                contact.email = value;
                widget.onChange?.call(_contacts);
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: "Email",
                  enabled: !skipValidation && widget.enable,
                  hintText: "nome.usuario@site.com"),
            ),
          ),
          SizedBox(
            width: context.onWideScreen(225, null),
            child: TextFormField(
              inputFormatters: [
                MaskTextInputFormatter(
                    mask: '+## (##) #####-####',
                    filter: {"#": RegExp(r'[0-9]')})
              ],
              validator: skipValidation
                  ? null
                  : (String? value) {
                      return Validator(value).isPhone();
                    },
              onChanged: (String value) {
                contact.phone = value;
                widget.onChange?.call(_contacts);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Telefone",
                  enabled: !skipValidation && widget.enable,
                  hintText: "+55 (31) 99999-9999"),
            ),
          ),
          if (button != null)
            button
          else
            Visibility(
              visible: widget.enable,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                height: 48,
                width: 48,
                child: IconButton(
                    onPressed: () {
                      if (!widget.canEmpty && _contacts.length == 1) return;
                      _contacts.remove(contact);
                      widget.onChange?.call(_contacts);
                      setState(() {});
                    },
                    icon: SizedBox(
                      child: Icon(
                        MdiIcons.close,
                        color: Colors.white,
                        size: 32,
                      ),
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
