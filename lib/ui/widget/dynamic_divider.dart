import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DynamicDivider extends StatefulWidget {
  final Widget leftChild;
  final Widget rightChild;
  final double dividerWidth;
  final double? leftChildInitialWidth;
  final double? leftChildInitialRate;
  final double? leftChildMinRate;
  final double? leftChildMaxRate;
  final double leftChildMinWidth;
  final double leftChildMaxWidth;

  const DynamicDivider({
    super.key,
    required this.leftChild,
    required this.rightChild,
    this.dividerWidth = 15,
    this.leftChildMinRate,
    this.leftChildMaxRate,
    this.leftChildInitialRate,
    this.leftChildInitialWidth,
    this.leftChildMaxWidth = double.infinity,
    this.leftChildMinWidth = 0,
  }) : assert(leftChildInitialRate == null || leftChildInitialWidth == null);

  @override
  State<DynamicDivider> createState() => _DynamicDividerState();
}

class _DynamicDividerState extends State<DynamicDivider> {
  late final ValueNotifier<double> leftWidthNotifier;

  double get initialWidth =>
      widget.leftChildInitialWidth ??
      (widget.leftChildInitialRate != null
          ? widget.leftChildInitialRate! * context.size!.width
          : context.size!.width / 2);

  double get maxWidth {
    if (widget.leftChildMaxRate != null) {
      return size.width * widget.leftChildMaxRate!;
    }
    return widget.leftChildMaxWidth;
  }

  double get minWidth {
    if (widget.leftChildMinRate != null) {
      return size.width * widget.leftChildMinRate!;
    }
    return widget.leftChildMinWidth;
  }

  Size get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    _updateOnResize();
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ValueListenableBuilder<double>(
            key: const Key('left-child'),
            valueListenable: leftWidthNotifier,
            builder: (BuildContext context, double value, Widget? child) {
              return SizedBox(
                width: value,
                child: widget.leftChild,
              );
            },
          ),
        ),
        GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            final double newValue = leftWidthNotifier.value + details.delta.dx;
            if (newValue > minWidth && newValue < maxWidth) {
              leftWidthNotifier.value = newValue;
            }
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.resizeColumn,
            child: SizedBox(
              width: widget.dividerWidth,
              child: const VerticalDivider(indent: 15, endIndent: 15),
            ),
          ),
        ),
        Expanded(
          key: const Key('right-child'),
          child: widget.rightChild,
        ),
      ],
    );
  }

  @override
  void initState() {
    leftWidthNotifier = ValueNotifier(250);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      leftWidthNotifier.value = initialWidth;
    });
    super.initState();
  }

  void _updateOnResize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (leftWidthNotifier.value > maxWidth) {
        leftWidthNotifier.value = maxWidth;
      }
      if (leftWidthNotifier.value < minWidth) {
        leftWidthNotifier.value = minWidth;
      }
    });
  }
}
