import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final String label;
  final bool enable;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const AppCheckbox({
    super.key,
    required this.label,
    required this.enable,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool checked = false;

  @override
  void initState() {
    checked = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enable,
      child: InkWell(
        onTap: () {
          checked = !checked;
          widget.onChanged(!checked);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                value: checked,
                onChanged: (_) {
                  checked = !checked;
                  widget.onChanged(!checked);
                }),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(widget.label),
            ),
          ],
        ),
      ),
    );
  }
}
