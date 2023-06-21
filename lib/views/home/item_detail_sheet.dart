import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/models/menu_items.dart';
import 'package:kaphia/utilities/constants/values.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/utilities/functions/update_checkout_model.dart';
import 'package:kaphia/views/shared/widgets/gap.dart';
import 'package:kaphia/views/shared/widgets/radius_clip.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../models/checkout.dart';
import '../../providers/checkout_model_provider.dart';
import '../../utilities/colors.dart';
import '../shared/widgets/loading_indicator.dart';

class ItemDetail extends ConsumerWidget {
  final Items item;
  const ItemDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context, ref) {
    CheckoutModel checkoutModel = ref.watch(checkoutModelProvider);

    return ProRadiusClip(
      customBorderRadius: BorderRadius.only(
        topLeft: Radius.circular(ProDesign.pt(20)),
        topRight: Radius.circular(ProDesign.pt(20)),
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Padding(padding: EdgeInsets.all(0)),
                Stack(
                  children: [
                    CachedNetworkImage(
                      height: ProDesign.vertically(40),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: item.image ?? "",
                      placeholder: (context, url) => const NormalLoader(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.fastfood,
                        size: ProDesign.pt(50),
                        color: ProjectColors.secondary400,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.1),
                      height: ProDesign.vertically(40),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ProTapper(
                        padding: EdgeInsets.all(ProDesign.pt(20)),
                        onTap: () {
                          pop();
                        },
                        child: ProShape(
                          height: ProDesign.pt(50),
                          width: ProDesign.pt(50),
                          radius: ProDesign.pt(25),
                          color: ProjectColors.white,
                          child: Icon(
                            Icons.close,
                            size: ProDesign.pt(50),
                            color: ProjectColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(ProDesign.pt(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ProText(
                                  text: item.name,
                                  fontSize: ProDesign.sp(18),
                                  color: ProjectColors.secondary500,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Gap(x: 20),
                              ProText(
                                text:
                                    "${ProjectValues.currencySymbol} ${item.price}",
                                fontSize: ProDesign.sp(18),
                                color: ProjectColors.secondary500,
                                fontWeight: FontWeight.w600,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          ProGap(y: ProDesign.pt(10)),
                          ProText(
                            text: item.description,
                            fontSize: ProDesign.sp(14),
                            color: ProjectColors.secondary400,
                            fontWeight: FontWeight.w500,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ProDesign.pt(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProButtonBasic(
                  height: ProDesign.pt(50),
                  width: ProDesign.pt(50),
                  borderRadius: ProDesign.pt(6),
                  customChild: Icon(
                    Icons.remove,
                    size: ProDesign.pt(28),
                    color: ProjectColors.red500,
                  ),
                  backgroundColor: ProjectColors.red500.withOpacity(0.15),
                  onTap: () {
                    removeCheckoutModelNormal(
                      ref: ref,
                      price: item.price,
                      removeID: item.id,
                    );
                  },
                ),
                const Gap(x: 10),
                ProCard(
                  height: ProDesign.pt(50),
                  width: ProDesign.pt(50),
                  borderRadius: ProDesign.pt(6),
                  padding: const EdgeInsets.all(0),
                  disableShadow: true,
                  backgroundColor: ProjectColors.grey200,
                  child: Center(
                    child: ProText(
                      text:
                          "${checkoutModel.orderItems != null && checkoutModel.orderItems!.isNotEmpty ? checkoutModel.orderItems!.firstWhere(
                                (element) => element.id == item.id,
                                orElse: () => CheckoutOrderItems(),
                              ).quantity ?? 0 : 0}",
                      fontSize: ProDesign.sp(20),
                      color: ProjectColors.secondary400,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                    ),
                  ),
                ),
                const Gap(x: 10),
                ProButtonBasic(
                  height: ProDesign.pt(50),
                  width: ProDesign.pt(50),
                  borderRadius: ProDesign.pt(6),
                  customChild: Icon(
                    Icons.add,
                    size: ProDesign.pt(28),
                    color: ProjectColors.green500,
                  ),
                  backgroundColor: ProjectColors.green500.withOpacity(0.15),
                  onTap: () {
                    addCheckoutModelNormal(ref: ref, item: item);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
