import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pro_design/pro_design.dart';

import '../../../utilities/colors.dart';

class NormalLoader extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? strokeWidth;
  const NormalLoader({super.key, this.size, this.color, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRing(
        color: color ?? ProjectColors.primary,
        size: size ?? ProDesign.pt(24),
        lineWidth: strokeWidth ?? ProDesign.pt(4),
      ),
    );
  }
}
