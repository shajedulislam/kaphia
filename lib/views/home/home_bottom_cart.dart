import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/providers/checkout_model_provider.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/views/home/loaders/charges_loader.dart';
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
            backgroundColor: ProjectColors.secondary500,
            borderRadius: 0,
            disableShadow: true,
            padding: EdgeInsets.symmetric(
                horizontal: ProDesign.pt(20), vertical: ProDesign.pt(10)),
            child: Row(
              children: [
                Expanded(
                  child: ProText(
                    text:
                        "${orderItems.length} ${orderItems.length > 1 ? "items" : "item"} added in food cart",
                    fontSize: ProDesign.sp(20),
                    fontWeight: FontWeight.w600,
                    color: ProjectColors.white,
                  ),
                ),
                ProButtonBasic(
                  width: ProDesign.horizontally(30),
                  height: ProDesign.pt(40),
                  borderRadius: ProDesign.pt(8),
                  fontSize: ProDesign.sp(16),
                  padding: EdgeInsets.symmetric(
                      horizontal: ProDesign.pt(8), vertical: ProDesign.pt(4)),
                  fontColor: ProjectColors.white,
                  backgroundColor: ProjectColors.red500,
                  customChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProText(
                        text: "View Cart",
                        fontSize: ProDesign.sp(18),
                        color: ProjectColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      const Gap(x: 16),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: ProDesign.pt(28),
                      )
                    ],
                  ),
                  onTap: () {
                    loader(screen: const ChargesLoader());
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
