import 'package:flutter/material.dart';

class SingleChildScrollBarView extends StatefulWidget {
  final Widget child;
  final ScrollController? horizontalScrollController;
  final ScrollController? verticalScrollController;

  const SingleChildScrollBarView({
    super.key,
    required this.child,
    this.horizontalScrollController,
    this.verticalScrollController,
  });

  @override
  State<SingleChildScrollBarView> createState() => _SingleChildScrollBarViewState();
}

class _SingleChildScrollBarViewState extends State<SingleChildScrollBarView> {
  late final ScrollController horizontalScrollController;

  late final ScrollController verticalScrollController;

  @override
  void initState() {
    horizontalScrollController = widget.horizontalScrollController ?? ScrollController();
    verticalScrollController = widget.verticalScrollController ?? ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: horizontalScrollController,
      child: SingleChildScrollView(
        controller: horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: Scrollbar(
          controller: verticalScrollController,
          child: SingleChildScrollView(
            controller: verticalScrollController,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
