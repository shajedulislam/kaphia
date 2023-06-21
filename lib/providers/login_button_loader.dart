import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginButtonLoader = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final orderButtonLoader = StateProvider.autoDispose<bool>((ref) {
  return false;
});
