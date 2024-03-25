import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  final IconData icon;
  final IconData? iconSelected;
  final String title;
  final String? subtitle;
  final void Function() onTap;
  final bool selected;
  final bool enabled;
  final bool mini;

  const ItemMenu({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.selected = false,
    this.enabled = true,
    this.mini = false,
    this.iconSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return const SizedBox.shrink();
    }
    return ListTile(
      enabled: enabled,
      leading: Tooltip(
          message: title, child: Icon(selected ? iconSelected ?? icon : icon)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
          ),
        ],
      ),
      isThreeLine: subtitle != null,
      selected: selected,
      onTap: () {
        if (selected) return;

        onTap.call();
      },
    );
  }
}
