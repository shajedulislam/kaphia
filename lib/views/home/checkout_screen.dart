import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/models/checkout.dart';
import 'package:kaphia/providers/checkout_model_provider.dart';
import 'package:kaphia/utilities/colors.dart';
import 'package:kaphia/utilities/constants/values.dart';
import 'package:kaphia/utilities/functions/gesture.dart';
import 'package:kaphia/views/home/checkout_bottom_order.dart';
import 'package:kaphia/views/shared/widgets/gap.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../utilities/functions/update_checkout_model.dart';

class CHeckoutScreen extends ConsumerWidget {
  const CHeckoutScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    CheckoutModel checkoutModel = ref.watch(checkoutModelProvider);
    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: Scaffold(
        backgroundColor: ProjectColors.background,
        appBar: AppBar(
          backgroundColor: ProjectColors.secondary500,
          title: Padding(
            padding: EdgeInsets.only(left: ProDesign.pt(6)),
            child: ProText(
              text: "Cart",
              fontSize: ProDesign.sp(20),
              color: ProjectColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: checkoutModel.orderItems != null &&
                checkoutModel.orderItems!.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(ProDesign.pt(20)),
                      itemCount: checkoutModel.orderItems!.length,
                      itemBuilder: (context, index) {
                        CheckoutOrderItems? orderItem =
                            checkoutModel.orderItems![index];
                        int? quantity = orderItem.quantity ?? 0;
                        int? price = orderItem.price ?? 0;

                        return quantity > 0 && price > 0
                            ? Padding(
                                padding:
                                    EdgeInsets.only(bottom: ProDesign.pt(20)),
                                child: ProCard(
                                    disableShadow: true,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(ProDesign.pt(20)),
                                    borderRadius: ProDesign.pt(8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: orderItem.variationType ==
                                                  "size"
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ProText(
                                                      text:
                                                          "${orderItem.name} - ${orderItem.size}",
                                                      fontSize:
                                                          ProDesign.sp(20),
                                                      color: ProjectColors
                                                          .secondary500,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const Gap(y: 10),
                                                    ProText(
                                                      text:
                                                          "${ProjectValues.currencySymbol} $price x $quantity = ${quantity * price} ${ProjectValues.currencySymbol}",
                                                      fontSize:
                                                          ProDesign.sp(16),
                                                      color: ProjectColors
                                                          .secondary400,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                              : orderItem.variationType ==
                                                      "side"
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ProText(
                                                              text:
                                                                  "${orderItem.name}",
                                                              fontSize:
                                                                  ProDesign.sp(
                                                                      20),
                                                              color: ProjectColors
                                                                  .secondary500,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            const Gap(y: 10),
                                                            ProText(
                                                              text:
                                                                  "Sides: ${orderItem.sides?.join(", ")}",
                                                              fontSize:
                                                                  ProDesign.sp(
                                                                      16),
                                                              color: ProjectColors
                                                                  .secondary400,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                        const Gap(y: 10),
                                                        ProText(
                                                          text:
                                                              "${ProjectValues.currencySymbol} $price x $quantity = ${quantity * price} ${ProjectValues.currencySymbol}",
                                                          fontSize:
                                                              ProDesign.sp(16),
                                                          color: ProjectColors
                                                              .secondary400,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ],
                                                    )
                                                  : orderItem.variationType ==
                                                          "none"
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ProText(
                                                              text:
                                                                  "${orderItem.name}",
                                                              fontSize:
                                                                  ProDesign.sp(
                                                                      20),
                                                              color: ProjectColors
                                                                  .secondary500,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            const Gap(y: 10),
                                                            ProText(
                                                              text:
                                                                  "${ProjectValues.currencySymbol} $price x $quantity = ${quantity * price} ${ProjectValues.currencySymbol}",
                                                              fontSize:
                                                                  ProDesign.sp(
                                                                      16),
                                                              color: ProjectColors
                                                                  .secondary400,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox.shrink(),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ProButtonBasic(
                                              height: ProDesign.pt(40),
                                              width: ProDesign.pt(40),
                                              borderRadius: ProDesign.pt(6),
                                              customChild: Icon(
                                                Icons.remove,
                                                size: ProDesign.pt(24),
                                                color: ProjectColors.red500,
                                              ),
                                              backgroundColor: ProjectColors
                                                  .red500
                                                  .withOpacity(0.15),
                                              onTap: () {
                                                removeFromCart(
                                                  ref: ref,
                                                  removeID: orderItem.id,
                                                );
                                              },
                                            ),
                                            const Gap(x: 10),
                                            ProCard(
                                              height: ProDesign.pt(40),
                                              width: ProDesign.pt(40),
                                              borderRadius: ProDesign.pt(6),
                                              padding: const EdgeInsets.all(0),
                                              disableShadow: true,
                                              backgroundColor:
                                                  ProjectColors.grey200,
                                              child: Center(
                                                child: ProText(
                                                  text: "$quantity",
                                                  fontSize: ProDesign.sp(20),
                                                  color: ProjectColors
                                                      .secondary400,
                                                  fontWeight: FontWeight.w500,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                            const Gap(x: 10),
                                            ProButtonBasic(
                                              height: ProDesign.pt(40),
                                              width: ProDesign.pt(40),
                                              borderRadius: ProDesign.pt(6),
                                              customChild: Icon(
                                                Icons.add,
                                                size: ProDesign.pt(24),
                                                color: ProjectColors.green500,
                                              ),
                                              backgroundColor: ProjectColors
                                                  .green500
                                                  .withOpacity(0.15),
                                              onTap: () {
                                                addMoreInCart(
                                                  ref: ref,
                                                  id: orderItem.id,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                  const CheckoutBottomOrder(),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
