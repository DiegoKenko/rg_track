abstract class PermissionsState {
  final List<String> available;
  final List<String> selected;
  final Map<String, String> permissionsMap;

  const PermissionsState(this.available, this.selected, this.permissionsMap);
}

class PermissionsInitial extends PermissionsState {
  const PermissionsInitial(
      super.available, super.selected, super.permissionsMap);

  const PermissionsInitial.empty() : super(const [], const [], const {});

  PermissionsState copyWith({
    List<String>? available,
    List<String>? selected,
    Map<String, String>? permissionsMap,
  }) {
    return PermissionsInitial(
      available ?? this.available,
      selected ?? this.selected,
      permissionsMap ?? this.permissionsMap,
    );
  }
}
