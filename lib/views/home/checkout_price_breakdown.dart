import 'package:flutter/material.dart';
import 'package:kaphia/models/price_breakdown.dart';
import 'package:kaphia/views/shared/widgets/gap.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/widgets/texts/text.dart';

import '../../utilities/colors.dart';
import '../../utilities/constants/values.dart';

class CheckoutPriceBreakdown extends StatelessWidget {
  final PriceBreakdownModel? breakdownModel;
  const CheckoutPriceBreakdown({super.key, this.breakdownModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProText(
          text:
              "Sub Total: ${breakdownModel?.subtotal ?? 0} ${ProjectValues.currencySymbol}",
          fontSize: ProDesign.sp(18),
          fontWeight: FontWeight.w600,
          color: ProjectColors.secondary500,
        ),
        const Gap(y: 4),
        ProText(
          text:
              "VAT: ${breakdownModel?.vat ?? 0} ${ProjectValues.currencySymbol}",
          fontSize: ProDesign.sp(18),
          fontWeight: FontWeight.w600,
          color: ProjectColors.secondary500,
        ),
        const Gap(y: 4),
        ProText(
          text:
              "Service Charge: ${breakdownModel?.serviceCharge ?? 0} ${ProjectValues.currencySymbol}",
          fontSize: ProDesign.sp(18),
          fontWeight: FontWeight.w600,
          color: ProjectColors.secondary500,
        ),
        const Gap(y: 10),
        ProText(
          text:
              "Total: ${breakdownModel?.total ?? 0} ${ProjectValues.currencySymbol}",
          fontSize: ProDesign.sp(24),
          fontWeight: FontWeight.w600,
          color: ProjectColors.green500,
        ),
      ],
    );
  }
}
