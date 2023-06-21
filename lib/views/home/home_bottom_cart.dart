import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/providers/checkout_model_provider.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/views/home/checkout_screen.dart';
import 'package:kaphia/views/shared/widgets/gap.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../models/checkout.dart';
import '../../utilities/colors.dart';

class HomeBottomCart extends ConsumerWidget {
  const HomeBottomCart({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Consumer(
      builder: (context, ref, child) {
        CheckoutModel checkoutModel = ref.watch(checkoutModelProvider);
        List<CheckoutOrderItems>? orderItems = checkoutModel.orderItems ?? [];

        if (orderItems.isNotEmpty) {
          return ProCard(
            borderColor: ProjectColors.secondary100,
            borderWidth: ProDesign.pt(1),
            backgroundColor: ProjectColors.grey200,
            disableShadow: true,
            child: Row(
              children: [
                Expanded(
                  child: ProText(
                    text:
                        "${orderItems.length} ${orderItems.length > 1 ? "items" : "item"} added in food cart",
                    fontSize: ProDesign.sp(20),
                    fontWeight: FontWeight.w600,
                    color: ProjectColors.secondary500,
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
                        text: "View Cart",
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
                    push(screen: const CHeckoutScreen());
                  },
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
