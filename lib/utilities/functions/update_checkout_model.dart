import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/models/checkout.dart';
import 'package:kaphia/models/menu_items.dart';
import 'package:kaphia/providers/checkout_model_provider.dart';
import 'package:kaphia/views/shared/widgets/snackbar.dart';

addCheckoutModelSize({
  required WidgetRef ref,
  required String itemName,
  required Sizes selectedSize,
}) {
  List<CheckoutOrderItems>? orderItems =
      ref.read(checkoutModelProvider).orderItems ?? [];

  if (orderItems.isNotEmpty) {
    CheckoutOrderItems? checkedItem;
    int index = -1;
    for (var element in orderItems) {
      index++;
      if (element.id == selectedSize.id) {
        checkedItem = element;
        break;
      }
    }
    if (checkedItem != null &&
        checkedItem.id != null &&
        checkedItem.quantity != null &&
        checkedItem.price != null) {
      checkedItem.quantity = checkedItem.quantity! + 1;
      checkedItem.price = selectedSize.price! * checkedItem.quantity!;
      orderItems[index] = checkedItem;
      ref.read(checkoutModelProvider.notifier).update(
            (state) => state.copyWith(orderItems: orderItems),
          );
    } else {
      orderItems.add(CheckoutOrderItems(
        id: selectedSize.id,
        name: itemName,
        size: selectedSize.name,
        price: selectedSize.price,
        quantity: 1,
        variationType: "size",
      ));
      ref.read(checkoutModelProvider.notifier).update(
            (state) => state.copyWith(orderItems: orderItems),
          );
    }
  } else {
    orderItems.add(CheckoutOrderItems(
      id: selectedSize.id,
      name: itemName,
      size: selectedSize.name,
      price: selectedSize.price,
      quantity: 1,
      variationType: "size",
    ));
    ref.read(checkoutModelProvider.notifier).update(
          (state) => state.copyWith(orderItems: orderItems),
        );
  }
}

removeCheckoutModelSize({
  required WidgetRef ref,
  required String itemName,
  required Sizes selectedSize,
}) {
  List<CheckoutOrderItems>? orderItems =
      ref.read(checkoutModelProvider).orderItems;

  if (orderItems != null && orderItems.isNotEmpty) {
    CheckoutOrderItems? checkedItem;
    int index = -1;
    for (var element in orderItems) {
      index++;
      if (element.id == selectedSize.id) {
        checkedItem = element;
        break;
      }
    }
    if (checkedItem != null &&
        checkedItem.id != null &&
        checkedItem.quantity != null &&
        checkedItem.price != null) {
      if (checkedItem.quantity! > 1) {
        checkedItem.quantity = checkedItem.quantity! - 1;
        checkedItem.price = selectedSize.price! * checkedItem.quantity!;
        orderItems[index] = checkedItem;
      } else if (checkedItem.quantity == 1) {
        orderItems.removeAt(index);
      }
      ref.read(checkoutModelProvider.notifier).update(
            (state) => state.copyWith(orderItems: orderItems),
          );
    }
  }
}

Future<bool> addCheckoutModelSide({
  required WidgetRef ref,
  required List<String> sideList,
  required int quantity,
  required Items item,
}) async {
  try {
    List<CheckoutOrderItems>? orderItems =
        ref.read(checkoutModelProvider).orderItems ?? [];

    orderItems.add(CheckoutOrderItems(
      id: item.id,
      name: item.name,
      price: item.price! * quantity,
      quantity: quantity,
      variationType: "side",
      sides: sideList,
    ));
    ref.read(checkoutModelProvider.notifier).update(
          (state) => state.copyWith(orderItems: orderItems),
        );
    return true;
  } catch (error) {
    showSnackBar(text: "Something went wrong while adding item.");
    return false;
  }
}

Future removeCheckoutModelSide({
  required WidgetRef ref,
  required String id,
}) async {
  List<CheckoutOrderItems>? orderItems =
      ref.read(checkoutModelProvider).orderItems;

  if (orderItems != null && orderItems.isNotEmpty) {
    int index = -1;
    for (var element in orderItems) {
      index++;
      if (element.id == id) {
        break;
      }
    }
    orderItems.removeAt(index);
    ref.read(checkoutModelProvider.notifier).update(
          (state) => state.copyWith(orderItems: orderItems),
        );
  }
}
