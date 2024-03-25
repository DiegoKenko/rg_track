import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/plan.dart';
import 'package:rg_track/ui/plans/cubit/plans_cubit.dart';
import 'package:rg_track/ui/plans/cubit/plans_state.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/form_title.dart';
import 'package:rg_track/ui/widget/left_right_selector.dart';
import 'package:rg_track/ui/widget/tags_manager.dart';
import 'package:rg_track/ui/widget/vehicles_form/permissions_cubit.dart';
import 'package:rg_track/ui/widget/vehicles_form/permissions_state.dart';
import 'package:rg_track/utils/bool_extension.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/currency_mask.dart';
import 'package:rg_track/utils/types.dart';

class PlanForm extends StatefulWidget {
  final ModelAction<Plan>? onSave;
  final WillPopUpAction<Plan>? willPopUp;
  final Plan? plan;
  final bool enable;

  const PlanForm({
    Key? key,
    this.onSave,
    this.willPopUp,
    this.enable = true,
    this.plan,
  }) : super(key: key);

  @override
  State<PlanForm> createState() => _PlanFormState();
}

class _PlanFormState extends State<PlanForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Plan _plan = Plan.empty();

  final TextEditingController _nameCtrl = TextEditingController(),
      _descriptionCtrl = TextEditingController(),
      _feePerVehicleInCentsCtrl = CurrencyTextInputMaskController();

  final FocusNode _nameFocus = FocusNode(),
      _descriptionFocus = FocusNode(),
      _feePerVehicleInCentsFocus = FocusNode(),
      _periodicityFocus = FocusNode(),
      _saveFocus = FocusNode();
  late final ValueNotifier<bool> _statusNotifier;

  late final PermissionsCubit _permissionCubit;

  @override
  void initState() {
    _loadPlanForm(widget.plan ?? Plan.empty());
    _permissionCubit = context.read<PermissionsCubit>();
    _permissionCubit.getPermissions(widget.plan?.abilities ?? const []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onWillPop: () async {
        return await widget.willPopUp?.call(_plan) ?? true;
      },
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(
            bottom: 128,
            left: context.onWideScreen(150, 16)!,
            top: context.onWideScreen(64, 0)!,
            right: context.onWideScreen(150, 16)!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormTitle('Informações'),
            TextFormField(
              controller: _nameCtrl,
              focusNode: _nameFocus,
              onChanged: (String value) {
                _plan = _plan.copyWith(name: value);
              },
              validator: (String? value) {
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_feePerVehicleInCentsFocus);
              },
              decoration: InputDecoration(
                enabled: widget.enable,
                label: const Text("Nome"),
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
                    controller: _feePerVehicleInCentsCtrl,
                    focusNode: _feePerVehicleInCentsFocus,
                    onChanged: (String value) {
                      _plan = _plan.copyWith(
                        priceVehicleCents:
                            int.tryParse(value.replaceAll(RegExp(r'\D'), '')),
                      );
                    },
                    validator: (String? value) {
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_periodicityFocus);
                    },
                    decoration: InputDecoration(
                      label: const Text('Valor por Veículo'),
                      enabled: widget.enable,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.onWideScreen(225, null),
                  child: IgnorePointer(
                    ignoring: !widget.enable,
                    child: DropdownButtonFormField<String>(
                      items: const {
                        'monthly': 'Mensal',
                        'bimonthly': 'Bimestral',
                        'quarterly': 'Trimestral',
                        'half yearly': 'Semestral',
                        'yearly': 'Anual'
                      }
                          .entries
                          .map((MapEntry<String, String> e) =>
                              DropdownMenuItem<String>(
                                value: e.key,
                                child: Text(e.value),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        _plan = _plan.copyWith(period: value);
                      },
                      validator: (String? value) {
                        return null;
                      },
                      focusNode: _periodicityFocus,
                      value: _plan.period.isEmpty ? null : _plan.period,
                      decoration: InputDecoration(
                        label: const Text('Periodicidade'),
                        enabled: widget.enable,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: context.onWideScreen(225, null),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _statusNotifier,
                      builder: (BuildContext context, bool value, __) =>
                          IgnorePointer(
                        ignoring: widget.enable.not,
                        child: SwitchListTile(
                          title: const Text('Status'),
                          value: _plan.isActive,
                          onChanged: (bool value) {
                            _plan = _plan.copyWith(isActive: value);
                            _statusNotifier.value = value;
                          },
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionCtrl,
              focusNode: _descriptionFocus,
              onChanged: (String value) {
                _plan = _plan.copyWith(description: value);
              },
              minLines: 3,
              maxLines: 8,
              decoration: InputDecoration(
                label: const Text('Descrição'),
                enabled: widget.enable,
              ),
            ),
            const FormTitle('Permissões'),
            BlocConsumer<PermissionsCubit, PermissionsState>(
              listener: (_, PermissionsState state) {
                _plan = _plan.copyWith(
                  abilities: state.permissionsMap.entries
                      .where((MapEntry<String, String> entry) =>
                          state.selected.contains(entry.key))
                      .map((MapEntry<String, String> entry) => entry.value)
                      .toList(),
                );
              },
              builder: (_, PermissionsState permissions) =>
                  LeftRightSelector<String>(
                left: permissions.available,
                right: permissions.selected,
                enabled: widget.enable,
                onLeftSelected: (String value) {
                  _permissionCubit.add(value);
                },
                onRightSelected: (String value) {
                  _permissionCubit.remove(value);
                },
                onRightAllSelected: (List<String> values) {
                  _permissionCubit.removeAll(values);
                },
                onLeftAllSelected: (List<String> values) {
                  _permissionCubit.addAll(values);
                },
              ),
            ),
            const FormTitle('Clientes'),
            TagsManager<Customer>(
              parseTitle: (Customer value) => value.bestName,
              onChange: (List<Customer> model) {},
            ),
            const SizedBox(height: 32),
            if (widget.enable)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<PlansCubit, PlansState>(
                    listener: _listenCubitStates,
                    builder: (BuildContext context, PlansState state) =>
                        ElevatedButton(
                      onPressed: state is PlanLoadingState ? () {} : _save,
                      focusNode: _saveFocus,
                      child: SizedBox(
                        width: context.onWideScreen(138, null),
                        height: 36,
                        child: Center(
                            child: Text(state is PlanLoadingState
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

  _save() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave?.call(_plan);
    }
  }

  void _listenCubitStates(BuildContext context, PlansState state) {
    if (state is PlanFailsState) {
      _formKey.currentState?.validate();
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialogFails(exception: state.exception));
      _formKey.currentState?.validate();
    }
    if (state is PlanSuccessfulState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Plano salvo com sucesso!'),
        backgroundColor: Colors.green,
      ));
      _formKey.currentState?.reset();
    }

    if (state is PlanLoadedState) {
      // _loadPlanForm(state.plan);
      setState(() {});
    }
  }

  void _loadPlanForm(Plan plan) {
    _plan = plan;
    _statusNotifier = ValueNotifier<bool>(plan.isActive);
    _feePerVehicleInCentsCtrl.text = "${_plan.priceVehicleCents}";
    _nameCtrl.text = _plan.name;
    _descriptionCtrl.text = _plan.description;
  }
}
