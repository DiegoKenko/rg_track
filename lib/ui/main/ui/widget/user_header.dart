import 'package:flutter/material.dart';
import 'package:rg_track/model/user.dart';

class UserHeader extends StatelessWidget {
  final bool mini;
  final UserEntity user;

  const UserHeader({
    super.key,
    required this.user,
    this.mini = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          /*  AnimatedContainer(
            clipBehavior: Clip.antiAlias,
            height: mini ? 50 : 60,
            width: mini ? 50 : 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            duration: const Duration(milliseconds: 250),
            child: Center(
                child: AnimatedDefaultTextStyle(
              style: Theme.of(context).textTheme.titleLarge!.apply(
                  fontWeightDelta: mini ? 1 : 2, fontSizeFactor: mini ? .8 : 1),
              duration: const Duration(milliseconds: 250),
              child: Text(
                _getInitials(user),
              ),
            )),
          ), */
          if (!mini) ...[
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name ?? 'Usuário',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  user.email?.toUpperCase() ?? 'user@host.com',
                )
              ],
            ),
            const Spacer(),
          ]
        ],
      ),
    );
  }
}
