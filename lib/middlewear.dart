import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/utilities/functions/middlewears.dart';
import 'package:pro_design/pro_design.dart';

import 'utilities/constants/enums.dart';
import 'views/shared/waiting_screen.dart';

class Middlewear extends ConsumerStatefulWidget {
  final Flavor flavor;
  const Middlewear({super.key, required this.flavor});

  @override
  ConsumerState<Middlewear> createState() => _MiddlewearState();
}

class _MiddlewearState extends ConsumerState<Middlewear> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      rootMiddleWear(flavor: widget.flavor, ref: ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProDesign.init(context, adjustor: 0.267);
    return const WatitingScreen();
  }
}
