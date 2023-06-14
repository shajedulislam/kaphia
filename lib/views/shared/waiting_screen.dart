import 'package:flutter/material.dart';

import '../../utilities/colors.dart';
import 'widgets/loading_indicator.dart';

class WatitingScreen extends StatelessWidget {
  const WatitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ProjectColors.white,
      body: Center(
        child: NormalLoader(),
      ),
    );
  }
}
