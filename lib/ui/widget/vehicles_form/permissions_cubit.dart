import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_list_utils/ms_list_utils.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/ui/widget/vehicles_form/permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit() : super(const PermissionsInitial.empty());

  Future<List<String>> getPermissions(
      [List<String> initialSelectedAbilities = const [],
      Customer? customer]) async {
    List<String> permissionsSource = [];

    final List<String> allPermissions =
        permissionsSource.map(_mapPermission).toList()..sort();
    final List<String> right =
        initialSelectedAbilities.map(_mapPermission).toList();
    final List<String> left = allPermissions.diff(right);
    emit(PermissionsInitial(
        left, right, Map.fromIterables(allPermissions, permissionsSource)));
    return allPermissions;
  }

  String _mapPermission(String e) {
    final List<String> values = e.split(':');
    final String context = values.first, ability = values.last;
    return "${_context[context]} - ${_ability[ability]}";
  }

  static const Map<String, String> _context = {
    "customers": "Clientes",
    "devices": "Dispositivos",
    "drivers": "Motoristas",
    "users": "Usuários",
    "vehicle kind": "Tipos de Veículo",
    "kind of fuel": "Tipos de Combustivel",
    "vehicle event": "Eventos de Veículo",
    "peripherals": "Perifericos",
    "vehicle": "Veículos",
    "cost centers": "Centros de Custo",
    "plans": "Planos",
    "maintenances": "Manutenções",
    "groups": "Grupos",
    "contracts": "Contratos",
    "itinerary": "Itinerário",
  };

  static const Map<String, String> _ability = {
    "u": "alterar",
    "s": "criar",
    "d": "apagar",
    "v": "visualizar",
    "i": "listar",
    "r": "restaurar",
    "au": "adicionar usuário",
    "du": "remover usuário",
    "av": "adicionar veículo",
    "dv": "remover veículo",
  };

  void remove(String p) {
    if (!{...state.available, ...state.selected}.contains(p)) {
      throw "Permissão desconhecida";
    }
    final PermissionsState listState = (state as PermissionsInitial).copyWith(
        available: [...state.available, p],
        selected: [...state.selected]..remove(p));
    emit(listState
      ..selected.sort()
      ..available.sort());
  }

  void add(String p) {
    if (!{...state.available, ...state.selected}.contains(p)) {
      throw "Permissão desconhecida";
    }
    final PermissionsState listState = (state as PermissionsInitial).copyWith(
        available: [...state.available]..remove(p),
        selected: [...state.selected, p]);
    emit(listState
      ..selected.sort()
      ..available.sort());
  }

  void removeAll(List<String> permissions) {
    final PermissionsState listState = (state as PermissionsInitial).copyWith(
        available: [...state.available, ...permissions], selected: []);
    emit(listState
      ..selected.sort()
      ..available.sort());
  }

  void addAll(List<String> permissions) {
    final PermissionsState listState = (state as PermissionsInitial)
        .copyWith(available: [], selected: [...state.selected, ...permissions]);
    emit(listState
      ..selected.sort()
      ..available.sort());
  }

  void addToAccount(Customer customer) {}
}
