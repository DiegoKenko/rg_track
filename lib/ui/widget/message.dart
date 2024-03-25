import 'package:flutter/material.dart';

typedef MessageAction = void Function();

class Message extends StatelessWidget {
  final String title, body;
  final String? actionText;
  final String? secondActionText;
  final IconData icon;
  final MessageAction? action;
  final MessageAction? secondAction;

  const Message({
    super.key,
    required this.title,
    required this.body,
    required this.icon,
    this.actionText,
    this.action,
    this.secondActionText,
    this.secondAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(color: Colors.transparent),
            Icon(
              icon,
              size: 100,
            ),
            const Divider(color: Colors.transparent),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(color: Colors.transparent),
            if (action != null && actionText != null)
              TextButton(
                onPressed: () => action?.call(),
                child: Text(actionText!.toUpperCase()),
              ),
            if (secondAction != null && secondActionText != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextButton(
                  onPressed: secondAction!,
                  child: Text(secondActionText!.toUpperCase()),
                ),
              )
          ],
        ),
      ),
    );
  }
}
