import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/providers/flavor.dart';

import 'middlewear.dart';
import 'utilities/constants/enums.dart';
import 'utilities/functions/call_back.dart';
import 'utilities/navigation.dart';
import 'utilities/singleton.dart';

class App extends ConsumerStatefulWidget {
  final Flavor flavor;
  const App({super.key, required this.flavor});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    callBackFunction(() {
      ref.read(flavorStateProvider.notifier).state = widget.flavor;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "bdfare",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Manrope',
      ),
      navigatorKey: locator<NavigationService>().globalNavigatorKey,
      scaffoldMessengerKey:
          locator<NavigationService>().globalScaffoldMessengerKey,
      home: Middlewear(flavor: widget.flavor),
    );
  }
}
