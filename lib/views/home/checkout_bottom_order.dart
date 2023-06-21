import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/providers/checkout_model_provider.dart';
import 'package:kaphia/utilities/constants/values.dart';
import 'package:kaphia/views/shared/widgets/gap.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../models/checkout.dart';
import '../../utilities/colors.dart';
import '../../utilities/functions/null_checker.dart';

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
            disableShadow: true,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProTextFormField(
                        hint: "Table Number",
                        width: ProDesign.pt(350),
                        paddingVertical: ProDesign.pt(20),
                        fontSize: ProDesign.sp(18),
                        fontWeight: FontWeight.w600,
                        fontColor: ProjectColors.secondary500,
                        hintColor: ProjectColors.secondary300,
                        hintFontSize: ProDesign.sp(18),
                        hintFontWeight: FontWeight.w500,
                        errorFontSize: ProDesign.sp(16),
                        errorFontWeight: FontWeight.w400,
                        errorFontColor: ProjectColors.red500,
                        backgroundColor: ProjectColors.white,
                        borderColorFocused: ProjectColors.primary,
                        borderColor: ProjectColors.grey400,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        borderRadius: ProDesign.pt(8),
                        // enabled: !ref.read(loginButtonLoader),
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
                      ProGap(y: ProDesign.pt(20)),
                      ProTextFormField(
                        hint: "Special Instruction",
                        width: double.infinity,
                        maxLines: 3,
                        paddingVertical: ProDesign.pt(20),
                        fontSize: ProDesign.sp(18),
                        borderRadius: ProDesign.pt(8),
                        fontWeight: FontWeight.w600,
                        fontColor: ProjectColors.secondary500,
                        hintColor: ProjectColors.secondary300,
                        hintFontSize: ProDesign.sp(18),
                        hintFontWeight: FontWeight.w500,
                        errorFontSize: ProDesign.sp(16),
                        errorFontWeight: FontWeight.w400,
                        errorFontColor: ProjectColors.red500,
                        backgroundColor: ProjectColors.white,
                        borderColorFocused: ProjectColors.primary,
                        borderColor: ProjectColors.grey400,
                        textInputAction: TextInputAction.done,
                        // enabled: !ref.read(loginButtonLoader),

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
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {}
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
