import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rg_track/model/address.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/types.dart';
import 'package:rg_track/utils/validator.dart';

class AddressFormWidget extends StatefulWidget {
  final bool enable;
  final Address? address;
  final ModelAction<Address>? onChange;
  final FocusNode? focus, nextFocus;

  const AddressFormWidget({
    Key? key,
    this.enable = true,
    this.address,
    this.onChange,
    this.focus,
    this.nextFocus,
  }) : super(key: key);

  @override
  State<AddressFormWidget> createState() => _AddressFormWidgetState();
}

class _AddressFormWidgetState extends State<AddressFormWidget> {
  final TextEditingController _zipCodeCtrl = TextEditingController(),
      _countryCtrl = TextEditingController(),
      _stateCtrl = TextEditingController(),
      _cityCtrl = TextEditingController(),
      _neighborhoodCtrl = TextEditingController(),
      _streetCtrl = TextEditingController(),
      _numberCtrl = TextEditingController(),
      _complementCtrl = TextEditingController();

  late final FocusNode _zipCodeFocus;
  final FocusNode _countryFocus = FocusNode(),
      _stateFocus = FocusNode(),
      _cityFocus = FocusNode(),
      _neighborhoodFocus = FocusNode(),
      _streetFocus = FocusNode(),
      _numberFocus = FocusNode(),
      _complementFocus = FocusNode();
  late Address _address;

  @override
  void initState() {
    _setAddress(widget.address ?? Address());
    _zipCodeFocus = widget.focus ?? FocusNode();
    super.initState();
  }

  _setAddress(Address? address) {
    _address = address ?? Address();
    _zipCodeCtrl.text = address!.zipCode ?? '';
    _countryCtrl.text = address.country ?? '';
    _stateCtrl.text = address.state ?? '';
    _cityCtrl.text = address.city ?? '';
    _neighborhoodCtrl.text = address.neighborhood ?? '';
    _streetCtrl.text = address.street ?? '';
    _numberCtrl.text = address.number ?? '';
    _complementCtrl.text = address.complement ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormTitle('Endereço'),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: context.onWideScreen(225, null),
              child: TextFormField(
                controller: _zipCodeCtrl,
                focusNode: _zipCodeFocus,
                inputFormatters: [
                  MaskTextInputFormatter(
                      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')})
                ],
                validator: (String? value) {
                  //Todo: Autocomplete do endereço pelo CEP
                  return Validator(value).isRequired();
                },
                onChanged: (String value) {
                  _address.zipCode = value;
                  _searchCep(value);
                  _updateChanges();
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "CEP",
                    enabled: widget.enable,
                    hintText: "00000-000"),
                onFieldSubmitted: (_) {
                  _zipCodeFocus.unfocus();
                  FocusScope.of(context).requestFocus(_countryFocus);
                },
              ),
            ),
            SizedBox(
              width: context.onWideScreen(225, null),
              child: TextFormField(
                controller: _countryCtrl,
                focusNode: _countryFocus,
                validator: (String? value) {
                  return Validator(value).isRequired();
                },
                onChanged: (String value) {
                  _address.country = value;
                  _updateChanges();
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    labelText: "País",
                    enabled: widget.enable,
                    hintText: "Brasil"),
                onFieldSubmitted: (_) {
                  _countryFocus.unfocus();
                  FocusScope.of(context).requestFocus(_stateFocus);
                },
              ),
            ),
            SizedBox(
              width: context.onWideScreen(225, null),
              child: TextFormField(
                controller: _stateCtrl,
                focusNode: _stateFocus,
                validator: (String? value) {
                  return Validator(value).isRequired();
                },
                onChanged: (String value) {
                  _address.state = value;
                  _updateChanges();
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    labelText: "Estado",
                    enabled: widget.enable,
                    hintText: "Minas Gerais"),
                onFieldSubmitted: (_) {
                  _stateFocus.unfocus();
                  FocusScope.of(context).requestFocus(_cityFocus);
                },
              ),
            ),
            SizedBox(
              width: context.onWideScreen(225, null),
              child: TextFormField(
                controller: _cityCtrl,
                focusNode: _cityFocus,
                validator: (String? value) {
                  return Validator(value).isRequired();
                },
                onChanged: (String value) {
                  _address.city = value;
                  _updateChanges();
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    labelText: "Cidade",
                    enabled: widget.enable,
                    hintText: "Sete Lagoas"),
                onFieldSubmitted: (_) {
                  _cityFocus.unfocus();
                  FocusScope.of(context).requestFocus(_neighborhoodFocus);
                },
              ),
            ),
            SizedBox(
              width: context.onWideScreen(225, null),
              child: TextFormField(
                controller: _neighborhoodCtrl,
                focusNode: _neighborhoodFocus,
                validator: (String? value) {
                  return Validator(value).isRequired();
                },
                onChanged: (String value) {
                  _address.neighborhood = value;
                  _updateChanges();
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    labelText: "Bairro",
                    enabled: widget.enable,
                    hintText: "Centro"),
                onFieldSubmitted: (_) {
                  _neighborhoodFocus.unfocus();
                  FocusScope.of(context).requestFocus(_streetFocus);
                },
              ),
            ),
            SizedBox(
              width: context.onWideScreen(225, null),
              child: TextFormField(
                controller: _streetCtrl,
                focusNode: _streetFocus,
                validator: (String? value) {
                  return Validator(value).isRequired();
                },
                onChanged: (String value) {
                  _address.street = value;
                  _updateChanges();
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    labelText: "Logradouro",
                    enabled: widget.enable,
                    hintText: "Rua José Duarte de Paiva"),
                onFieldSubmitted: (_) {
                  _streetFocus.unfocus();
                  FocusScope.of(context).requestFocus(_numberFocus);
                },
              ),
            ),
            SizedBox(
              width: context.onWideScreen(225, null),
              child: TextFormField(
                controller: _numberCtrl,
                focusNode: _numberFocus,
                validator: (String? value) {
                  return Validator(value).isRequired();
                },
                onChanged: (String value) {
                  _address.number = value;
                  _updateChanges();
                },
                decoration: InputDecoration(
                    labelText: "Número",
                    enabled: widget.enable,
                    hintText: "1234"),
                onFieldSubmitted: (_) {
                  _numberFocus.unfocus();
                  FocusScope.of(context).requestFocus(_complementFocus);
                },
              ),
            ),
            SizedBox(
              width: context.onWideScreen(225, null),
              child: TextFormField(
                controller: _complementCtrl,
                focusNode: _complementFocus,
                validator: (String? value) {
                  return Validator(value).isNull();
                },
                onChanged: (String value) {
                  _address.complement = value;
                  _updateChanges();
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Complemento",
                  enabled: widget.enable,
                ),
                onFieldSubmitted: (_) {
                  _complementFocus.unfocus();
                  FocusScope.of(context).requestFocus(widget.nextFocus);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _updateChanges() {
    widget.onChange?.call(_address);
  }

  Future<void> _searchCep(String? cep) async {
    if (RegExp(r"\d{5}-?\d{3}").hasMatch(cep ?? '')) {
      final Response res = await Dio().getUri(Uri.parse(
          "https://viacep.com.br/ws/${cep!.replaceAll('-', '')}/json/"));
      if (res.statusCode != 200) return;
      _setAddress(Address(
        zipCode: cep,
        state: res.data['uf'] ?? '',
        city: res.data['localidade'] ?? '',
        neighborhood: res.data['bairro'] ?? '',
        country: 'Brasil',
        street: res.data['logradouro'] ?? '',
      ));
      _numberFocus.requestFocus();
      _updateChanges();
    }
  }
}
