import 'package:get_it/get_it.dart';

import 'navigation.dart';
import 'shared_preference.dart';

GetIt locator = GetIt.instance;

Future<void> registerSingletons() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SharedPreferenceService());
}
