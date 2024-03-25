import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/ui/widget/row_or_column.dart';
import 'package:rg_track/utils/bool_extension.dart';
import 'package:rg_track/utils/screen_utils.dart';
import 'package:string_to_hex/string_to_hex.dart';

typedef CallBack<C> = void Function(C value);

class LeftRightSelector<T> extends StatelessWidget {
  final List<T> left;
  final List<T> right;
  final bool enabled;
  final CallBack<T> onLeftSelected;
  final CallBack<List<T>>? onLeftAllSelected;
  final CallBack<T> onRightSelected;
  final CallBack<List<T>>? onRightAllSelected;

  LeftRightSelector({
    super.key,
    required this.left,
    required this.right,
    required this.onLeftSelected,
    required this.onRightSelected,
    this.enabled = true,
    this.onLeftAllSelected,
    this.onRightAllSelected,
  });

  final BoxDecoration _commonBoxDecoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      border: Border.all(color: Colors.black26));

  @override
  Widget build(BuildContext context) {
    return RowOrColumn(
      mode:
          isWideScreen(context) ? RowOrColumnMode.row : RowOrColumnMode.column,
      removeExpanded: true,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: _commonBoxDecoration,
            width: isWideScreen(context) ? null : double.infinity,
            constraints: const BoxConstraints(
              minHeight: 250,
              maxHeight: 400,
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    if (onLeftAllSelected != null)
                      ActionChip(
                        label: const Text('Adicionar Todos'),
                        avatar: const Icon(Icons.playlist_add),
                        onPressed: () {
                          if (enabled.not) return;
                          onLeftAllSelected?.call(left);
                        },
                      ),
                    ...left
                        .map<Widget>(
                          (T p) => ActionChip(
                            label: Text(p.toString()),
                            backgroundColor: Color(StringToHex.toColor(p
                                    .toString()
                                    .split('- ')
                                    .first
                                    .padRight(18, '-')))
                                .withOpacity(0.15),
                            onPressed: () {
                              if (enabled.not) return;
                              onLeftSelected(p);
                            },
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(isWideScreen(context)
              ? MdiIcons.arrowRightThick
              : MdiIcons.arrowDownThick),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: _commonBoxDecoration,
            width: isWideScreen(context) ? null : double.infinity,
            constraints: const BoxConstraints(
              minHeight: 250,
              maxHeight: 400,
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    if (onRightAllSelected != null)
                      ActionChip(
                        label: const Text('Remover Todos'),
                        avatar: const Icon(Icons.playlist_remove),
                        onPressed: () {
                          if (enabled.not) return;
                          onRightAllSelected?.call(right);
                        },
                      ),
                    ...right
                        .map<Widget>(
                          (T p) => Chip(
                            label: Text(p.toString()),
                            backgroundColor: Color(StringToHex.toColor(p
                                    .toString()
                                    .split('- ')
                                    .first
                                    .padRight(18, '-')))
                                .withOpacity(0.15),
                            onDeleted: () {
                              if (enabled.not) return;
                              onRightSelected(p);
                            },
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
