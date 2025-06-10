import 'package:flutter/material.dart';

class ContainerInk extends StatelessWidget {
  const ContainerInk({
    super.key,
    required this.child,
    this.borderRadius,
  });

  final Widget child;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final Material w = Material(
      type: MaterialType.transparency,
      child: child,
    );

    if (borderRadius == null) {
      return ClipOval(child: w);
    }

    return ClipRRect(
      borderRadius: borderRadius!,
      child: w,
    );
  }
}
