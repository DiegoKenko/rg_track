import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/ui/users/child/single/cubit/users_child_single_cubit.dart';
import 'package:rg_track/ui/users/child/single/cubit/users_child_single_state.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/utils/bool_extension.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/validator.dart';

class UserForm extends StatefulWidget {
  final UserEntity user;
  final String? id;
  final EnumFormOption formOption;

  const UserForm({
    required this.formOption,
    required this.user,
    super.key,
    this.id,
  });

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _savingNotifier = ValueNotifier<bool>(false);
  UserEntity _user = UserEntity.commom();
  bool enable = false;
  bool saved = false;

  final TextEditingController _nameCtrl = TextEditingController(),
      _emailCtrl = TextEditingController(),
      _phoneCtrl = TextEditingController(),
      _startOfTheJourneyCtrl = TextEditingController(),
      _endOfTheJourneyCtrl = TextEditingController(),
      _documentCtrl = TextEditingController();

  bool _isWhatsApp = true;

  final FocusNode _nameFocus = FocusNode(),
      _emailFocus = FocusNode(),
      _phoneFocus = FocusNode(),
      _documentFocus = FocusNode(),
      _saveFocus = FocusNode();

  @override
  void initState() {
    _user = widget.user;
    enable = !(widget.formOption == EnumFormOption.VIEW);
    _loadUserForm();

    super.initState();
  }

  void _loadUserForm() {
    _nameCtrl.text = widget.user.name ?? '';
    _emailCtrl.text = widget.user.email ?? '';
    _phoneCtrl.text = widget.user.phone ?? '';
    _startOfTheJourneyCtrl.text = widget.user.startOfTheJourney ?? '';
    _endOfTheJourneyCtrl.text = widget.user.endOfTheJourney ?? '';
    _documentCtrl.text = widget.user.document ?? '';
    _isWhatsApp = widget.user.isWhatsApp;
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
        child: BlocConsumer<UserChildSingleCubit, UserChildSingleState>(
            listener: (context, state) {
          if (state is UserChildSingleSuccessfulState) {
            _onSuccess(state);
          } else if (state is UserChildSingleErrorState) {
            _onFailure(state);
          }
        }, builder: (context, state) {
          bool loading = false;
          if (state is UserChildSingleLoadingState) {
            loading = true;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              const FormTitle(
                'Dados pessoais',
                padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      controller: _nameCtrl,
                      focusNode: _nameFocus,
                      validator: (String? value) {
                        return Validator(value).isRequired.isName();
                      },
                      onChanged: (String value) {
                        _user = _user.copyWith(name: value);
                      },
                      decoration: InputDecoration(
                        labelText: "Nome Completo",
                        enabled: enable,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      controller: _documentCtrl,
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '###.###.###-##',
                            filter: {"#": RegExp(r'\d')})
                      ],
                      focusNode: _documentFocus,
                      validator: (String? value) {
                        return Validator(value).isCpfValid();
                      },
                      onChanged: (String value) {
                        _user = _user.copyWith(document: value);
                      },
                      decoration: InputDecoration(
                        labelText: "Documento",
                        enabled: enable,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      controller: _emailCtrl,
                      focusNode: _emailFocus,
                      validator: (String? value) {
                        return Validator(value).isRequired.isEmailValid();
                      },
                      onChanged: (String value) {
                        _user = _user.copyWith(email: value);
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        enabled: enable,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.onWideScreen(225, null),
                    child: TextFormField(
                      controller: _phoneCtrl,
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '+## (##) #####-####',
                            filter: {"#": RegExp(r'\d')})
                      ],
                      onChanged: (String value) {
                        _user = _user.copyWith(phone: value);
                      },
                      focusNode: _phoneFocus,
                      validator: (String? value) {
                        return Validator(value).isPhone();
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Celular",
                        enabled: enable,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.onWideScreen(225, null),
                    child: SwitchListTile(
                      title: const Text('É WhatsApp?'),
                      value: _isWhatsApp,
                      onChanged: (bool value) {
                        if (enable.not) return;
                        _isWhatsApp = !_isWhatsApp;
                        _user = _user.copyWith(isWhatsApp: _isWhatsApp);
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
              /*  const FormTitle(
                    'Horário de trabalho',
                    padding: EdgeInsets.only(top: 48, bottom: 8, left: 8, right: 8),
                  ),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: context.onWideScreen(225, null),
                        child: TextFormField(
                          controller: _startOfTheJourneyCtrl,
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '##:##', filter: {"#": RegExp(r'\d')})
                          ],
                          focusNode: _startOfTheJourneyFocus,
                          validator: (String? value) {
                            return Validator(value).isTime();
                          },
                          onChanged: (String value) {
                            _user = _user.copyWith(startOfTheJourney: value);
                          },
                          keyboardType: TextInputType.datetime,
                          maxLength: 5,
                          decoration: InputDecoration(
                              labelText: "Início da jornada",
                              enabled: enable,
                              hintText: "HH:mm"),
                        ),
                      ),
                      SizedBox(
                        width: context.onWideScreen(225, null),
                        child: TextFormField(
                          controller: _endOfTheJourneyCtrl,
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '##:##', filter: {"#": RegExp(r'\d')})
                          ],
                          focusNode: _endOfTheJouFocus,
                          validator: (String? value) {
                            return Validator(value).isTime();
                          },
                          onChanged: (String value) {
                            _user = _user.copyWith(endOfTheJourney: value);
                          },
                          keyboardType: TextInputType.datetime,
                          maxLength: 5,
                          decoration: InputDecoration(
                              labelText: "Fim da jornada",
                              enabled: enable,
                              hintText: "HH:mm"),
                        ),
                      ),
                    ],
                  ), */
              /*   const FormTitle(
                    'Permissões',
                    padding: EdgeInsets.only(top: 48, bottom: 8, left: 8, right: 8),
                  ),
                  BlocConsumer<PermissionsCubit, PermissionsState>(
                    listener: (_, PermissionsState state) {
                      _user = _user.copyWith(
                        abilities: state.permissionsMap.entries
                            .where((MapEntry<String, String> entry) =>
                                state.selected.contains(entry.key))
                            .map((MapEntry<String, String> entry) => entry.value)
                            .toList(),
                      );
                    },
                    builder: (_, PermissionsState permissions) => LeftRightSelector(
                      left: permissions.available,
                      right: permissions.selected,
                      enabled: enable,
                      onLeftSelected: (String value) {
                        _permissionsCubit.add(value);
                      },
                      onRightSelected: (String value) {
                        _permissionsCubit.remove(value);
                      },
                      onRightAllSelected: (List<String> values) {
                        _permissionsCubit.removeAll(values);
                      },
                      onLeftAllSelected: (List<String> values) {
                        _permissionsCubit.addAll(values);
                      },
                    ),
                  ), */
              /*  VehiclesFormWidget(
                    enable: enable,
                    onChange: (List<Vehicle> vehicles) {
                      _vehicles = vehicles;
                    },
                  ),
                  const SizedBox(height: 16),
                  if (enable)
                    BlocBuilder<UserParentCubit, UserParentState>(
                      builder: (BuildContext context, UserParentState state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: state is UserChildSingleLoadingState
                                    ? null
                                    : () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          widget.onSave
                                              ?.call(_user, _vehicles, _customer!);
                                        }
                                      },
                                child: SizedBox(
                                    width: context.onWideScreen(150, null),
                                    height: 36,
                                    child: const Center(child: Text('Salvar')))),
                          ],
                        );
                      },
                    ),
                  BlocListener<UserParentCubit, UserParentState>(
                    listener: (_, UserParentState state) {
                      onFun<UserChildSingleSuccessfulState>(state, _onSuccess);
                      onFun<UserChildSingleErrorState>(state, _onFailure);
                    },
                    child: const SizedBox(),
                  ), */
              saved || !enable
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: loading
                                ? () {}
                                : () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      _savingNotifier.value = true;
                                      if (widget.formOption ==
                                          EnumFormOption.CREATE) {
                                        UserEntity? user = await context
                                            .read<UserChildSingleCubit>()
                                            .createUser(_user);
                                        if (user != null) {}
                                      }
                                      if (widget.formOption ==
                                          EnumFormOption.UPDATE) {
                                        await context
                                            .read<UserChildSingleCubit>()
                                            .update(_user);
                                      }

                                      _savingNotifier.value = false;
                                    }
                                  },
                            focusNode: _saveFocus,
                            child: SizedBox(
                              width: 138,
                              height: 36,
                              child: Center(
                                  child:
                                      Text(loading ? 'Salvando..' : 'Salvar')),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          );
        }),
      ),
    );
  }

  void _onFailure(UserChildSingleErrorState state) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogFails(
        exception: state.error,
      ),
    );
  }

  void _onSuccess(UserChildSingleSuccessfulState value) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Usuário salvo com sucesso!'),
      backgroundColor: Colors.green,
    ));
    _formKey.currentState?.reset();
    Navigator.of(context).pop();
  }
}
