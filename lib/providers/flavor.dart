import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utilities/constants/enums.dart';

final flavorStateProvider = StateProvider<Flavor>((ref) {
  return Flavor.devBd;
});
