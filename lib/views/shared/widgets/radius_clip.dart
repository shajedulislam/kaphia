import 'package:flutter/material.dart';
import 'package:pro_design/pro_design.dart';

class ProRadiusClip extends StatelessWidget {
  final Widget? child;
  final double? borderRadius;
  final BorderRadius? customBorderRadius;

  const ProRadiusClip({
    super.key,
    this.child,
    this.borderRadius,
    this.customBorderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: customBorderRadius ??
          BorderRadius.all(
            Radius.circular(borderRadius ?? ProDesign.pt(4)),
          ),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
