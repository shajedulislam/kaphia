import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'utilities/constants/enums.dart';
import 'utilities/singleton.dart';

Future<void> runner({required Flavor flavor}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await registerSingletons();
  runApp(ProviderScope(child: App(flavor: flavor)));
}
