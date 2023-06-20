import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/models/checkout.dart';

final checkoutModelProvider = StateProvider<CheckoutModel>((ref) {
  return CheckoutModel(
    orderDate: DateTime.now().toString(),
    orderStatus: "pending",
    orderItems: [],
  );
});
