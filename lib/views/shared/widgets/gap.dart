import 'package:flutter/material.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

class Gap extends StatelessWidget {
  final double? x;
  final double? y;
  const Gap({super.key, this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return ProGap(
      x: ProDesign.pt(x ?? 0),
      y: ProDesign.pt(y ?? 0),
    );
  }
}
