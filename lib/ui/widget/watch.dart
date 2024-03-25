import 'package:flutter/material.dart';

class Watch extends StatefulWidget {
  final Duration duration;
  final void Function()? onTimeout;

  const Watch({required this.duration, this.onTimeout, super.key});

  @override
  State<Watch> createState() => _WatchState();
}

class _WatchState extends State<Watch> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          widget.onTimeout?.call();
        }
      })
      ..addListener(() {
        setState(() {});
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: _controller.value,
      strokeWidth: 2,
    );
  }
}
