import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/providers/checkout_model_provider.dart';
import 'package:kaphia/providers/login_button_loader.dart';
import 'package:kaphia/utilities/constants/values.dart';
import 'package:kaphia/utilities/functions/formatter.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/views/shared/widgets/gap.dart';
import 'package:kaphia/views/shared/widgets/snackbar.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../models/checkout.dart';
import '../../utilities/colors.dart';
import '../../utilities/functions/null_checker.dart';
import '../shared/widgets/loading_indicator.dart';

class CheckoutBottomOrder extends ConsumerStatefulWidget {
  const CheckoutBottomOrder({super.key});

  @override
  ConsumerState<CheckoutBottomOrder> createState() =>
      _CheckoutBottomOrderState();
}

class _CheckoutBottomOrderState extends ConsumerState<CheckoutBottomOrder> {
  late String tableNumber;
  late String specialInstruction;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  placeOrder() {
    CheckoutModel checkoutModel = ref.read(checkoutModelProvider);
    int totalMoney = 0;
    checkoutModel.orderItems?.forEach((element) {
      if (element.price != null &&
          element.price! > 0 &&
          element.quantity != null &&
          element.quantity! > 0) {
        totalMoney = totalMoney + (element.price! * element.quantity!);
      }
    });

    String orderDate = ProFormatter()
        .dateTimeFormatter(format: "dd-MM-yyyy", dateTime: DateTime.now());
    checkoutModel.orderId = "o${DateTime.now().millisecondsSinceEpoch}";
    checkoutModel.orderDate = orderDate;
    checkoutModel.orderBill = totalMoney;
    checkoutModel.orderTime = ProFormatter()
        .dateTimeFormatter(format: "hh:mm aa", dateTime: DateTime.now());

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('order').doc(orderDate);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      int totalOrders = 0;
      if (!snapshot.exists) {
        checkoutModel.orderNumber = 1;
        totalOrders = 1;

        transaction.set(
          documentReference,
          {
            "total_orders": totalOrders,
            "orders": FieldValue.arrayUnion(
              [
                checkoutModel.toJson(),
              ],
            )
          },
        );
      } else {
        Map dataDB = snapshot.data() as Map<String, dynamic>;
        totalOrders = dataDB['total_orders'] + 1;
        checkoutModel.orderNumber = totalOrders;
        transaction.update(
          documentReference,
          {
            "total_orders": totalOrders,
            "orders": FieldValue.arrayUnion(
              [
                checkoutModel.toJson(),
              ],
            )
          },
        );
      }
    }).then((_) {
      showSnackBar(
        text: "Order placed successfully.",
        color: ProjectColors.green500,
      );
      ref.invalidate(checkoutModelProvider);
      ref.read(orderButtonLoader.notifier).update((state) => false);
      pop();
    }).catchError((error) {
      ref.read(orderButtonLoader.notifier).update((state) => false);
      showSnackBar(
        text: "Something went wrong while placing the order. Please try again.",
        color: ProjectColors.red500,
      );
    });
  }

  int totalMoneyCounter(List<CheckoutOrderItems> orderItemsTemp) {
    int totalMoney = 0;
    for (var element in orderItemsTemp) {
      if (element.price != null &&
          element.price! > 0 &&
          element.quantity != null &&
          element.quantity! > 0) {
        totalMoney = totalMoney + (element.price! * element.quantity!);
      }
    }
    return totalMoney;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        CheckoutModel checkoutModel = ref.watch(checkoutModelProvider);
        List<CheckoutOrderItems>? orderItems = checkoutModel.orderItems ?? [];

        if (orderItems.isNotEmpty) {
          return ProCard(
            borderRadius: 0,
            borderColor: ProjectColors.primary100,
            borderWidth: ProDesign.pt(1),
            backgroundColor: ProjectColors.grey200,
            padding: EdgeInsets.all(ProDesign.pt(20)),
            disableShadow: true,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProTextFormField(
                        hint: "Table Number",
                        width: ProDesign.horizontally(30),
                        paddingVertical: ProDesign.pt(20),
                        fontSize: ProDesign.sp(16),
                        fontWeight: FontWeight.w500,
                        fontColor: ProjectColors.secondary500,
                        hintColor: ProjectColors.secondary300,
                        hintFontSize: ProDesign.sp(16),
                        hintFontWeight: FontWeight.w400,
                        errorFontSize: ProDesign.sp(14),
                        errorFontWeight: FontWeight.w400,
                        errorFontColor: ProjectColors.red500,
                        backgroundColor: ProjectColors.white,
                        borderColorFocused: ProjectColors.primary,
                        borderColor: ProjectColors.grey400,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        borderRadius: ProDesign.pt(8),
                        enabled: !ref.read(orderButtonLoader),
                        onChanged: (value) {
                          tableNumber = value;
                          ref
                              .read(checkoutModelProvider.notifier)
                              .state
                              .tableNumber = value;
                        },
                        validator: (value) {
                          if (isNull(value)) {
                            return 'Please enter table number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Gap(x: 20),
                      Expanded(
                        child: ProTextFormField(
                          hint: "Special Instruction",
                          width: double.infinity,
                          paddingVertical: ProDesign.pt(20),
                          fontSize: ProDesign.sp(16),
                          borderRadius: ProDesign.pt(8),
                          fontWeight: FontWeight.w500,
                          fontColor: ProjectColors.secondary500,
                          hintColor: ProjectColors.secondary300,
                          hintFontSize: ProDesign.sp(16),
                          hintFontWeight: FontWeight.w400,
                          errorFontSize: ProDesign.sp(16),
                          errorFontWeight: FontWeight.w400,
                          errorFontColor: ProjectColors.red500,
                          backgroundColor: ProjectColors.white,
                          borderColorFocused: ProjectColors.primary,
                          borderColor: ProjectColors.grey400,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          enabled: !ref.read(orderButtonLoader),
                          onChanged: (value) {
                            specialInstruction = value;
                            ref
                                .read(checkoutModelProvider.notifier)
                                .state
                                .specialInstruction = value;
                          },
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ProGap(y: ProDesign.pt(20)),
                Row(
                  children: [
                    Expanded(
                      child: ProText(
                        text:
                            "Total: ${totalMoneyCounter(orderItems)} ${ProjectValues.currencySymbol}",
                        fontSize: ProDesign.sp(24),
                        fontWeight: FontWeight.w600,
                        color: ProjectColors.green500,
                      ),
                    ),
                    ProButtonBasic(
                      width: ProDesign.horizontally(30),
                      height: ProDesign.pt(50),
                      borderRadius: ProDesign.pt(8),
                      fontSize: ProDesign.sp(16),
                      fontColor: ProjectColors.white,
                      backgroundColor: ProjectColors.red500,
                      customChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ref.watch(orderButtonLoader) != true
                              ? Row(
                                  children: [
                                    ProText(
                                      text: "Place Order",
                                      fontSize: ProDesign.sp(20),
                                      color: ProjectColors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const Gap(x: 16),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: ProDesign.pt(28),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    ProText(
                                      text: "Please Wait",
                                      fontSize: ProDesign.sp(20),
                                      color: ProjectColors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const Gap(x: 16),
                                    const NormalLoader(
                                      color: ProjectColors.white,
                                    )
                                  ],
                                )
                        ],
                      ),
                      onTap: () {
                        if (ref.read(orderButtonLoader) != true) {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(orderButtonLoader.notifier)
                                .update((state) => true);
                            placeOrder();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
