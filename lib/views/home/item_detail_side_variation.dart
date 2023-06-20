import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/models/checkout.dart';
import 'package:kaphia/models/menu_items.dart';
import 'package:kaphia/utilities/constants/values.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/utilities/functions/update_checkout_model.dart';
import 'package:kaphia/views/shared/widgets/gap.dart';
import 'package:kaphia/views/shared/widgets/radius_clip.dart';
import 'package:kaphia/views/shared/widgets/snackbar.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../providers/checkout_model_provider.dart';
import '../../utilities/colors.dart';
import '../shared/widgets/loading_indicator.dart';

class ItemDetailSideVariation extends ConsumerStatefulWidget {
  final Items item;
  const ItemDetailSideVariation({super.key, required this.item});

  @override
  ConsumerState<ItemDetailSideVariation> createState() =>
      _ItemDetailSideVariationState();
}

class _ItemDetailSideVariationState
    extends ConsumerState<ItemDetailSideVariation> {
  final _selectedSidesProvider =
      StateProvider.autoDispose<List<String>?>((ref) {
    return [];
  });
  final _selectedQuantityProvider = StateProvider.autoDispose<int>((ref) {
    return 0;
  });
  List<String> selectedSides = [];
  int selectedQuantity = 0;

  @override
  Widget build(BuildContext context) {
    CheckoutModel checkoutModel = ref.watch(checkoutModelProvider);
    selectedSides = ref.watch(_selectedSidesProvider) ?? [];
    selectedQuantity = ref.watch(_selectedQuantityProvider) ?? 0;
    print(checkoutModel.toJson());
    return ProRadiusClip(
      customBorderRadius: BorderRadius.all(Radius.circular(ProDesign.pt(12))),
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
                      imageUrl: widget.item.image ?? "",
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
                    ProCard(
                      borderRadius: 0,
                      gradientEnable: true,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                      height: ProDesign.vertically(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ProText(
                                  text: widget.item.name,
                                  fontSize: ProDesign.sp(18),
                                  color: ProjectColors.white,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Gap(x: 20),
                              ProText(
                                text:
                                    "${ProjectValues.currency} ${widget.item.price}",
                                fontSize: ProDesign.sp(18),
                                color: ProjectColors.white,
                                fontWeight: FontWeight.w600,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          ProGap(y: ProDesign.pt(10)),
                          ProText(
                            text: widget.item.description,
                            fontSize: ProDesign.sp(14),
                            color: ProjectColors.white,
                            fontWeight: FontWeight.w500,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
                      ProText(
                        text:
                            "Select Sides (Any ${widget.item.sideSelectionLimit})",
                        fontSize: ProDesign.sp(20),
                        color: ProjectColors.secondary500,
                        fontWeight: FontWeight.w600,
                      ),
                      const Gap(y: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.item.sides!.map((side) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: ProDesign.pt(16),
                            ),
                            child: ProTapper(
                              padding: const EdgeInsets.all(0),
                              onTap: () {
                                if (selectedSides.contains(side)) {
                                  selectedSides.remove(side);
                                } else {
                                  if (selectedSides.length <
                                      widget.item.sideSelectionLimit!) {
                                    selectedSides.add(side);
                                  } else {
                                    showSnackBar(
                                      text:
                                          "Maximum ${widget.item.sideSelectionLimit} sides can be selected for this item.",
                                      color: ProjectColors.red500,
                                    );
                                  }
                                }
                                ref
                                    .read(_selectedSidesProvider.notifier)
                                    .state = selectedSides.toList();
                              },
                              child: ProCard(
                                width: double.infinity,
                                borderRadius: ProDesign.pt(6),
                                disableShadow: true,
                                backgroundColor: ProjectColors.grey200,
                                padding: EdgeInsets.symmetric(
                                    horizontal: ProDesign.pt(10),
                                    vertical: ProDesign.pt(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ProRadioButton(
                                      checked: selectedSides.isNotEmpty &&
                                          selectedSides.contains(side),
                                      title: "",
                                      radioTitleGap: 0,
                                      radioColor: ProjectColors.primary,
                                      titleFontSize: ProDesign.sp(20),
                                      titleWeight: FontWeight.w500,
                                      titleColor: ProjectColors.secondary400,
                                      size: ProDesign.pt(20),
                                    ),
                                    const Gap(x: 10),
                                    Expanded(
                                      child: ProText(
                                        text: side,
                                        fontSize: ProDesign.sp(20),
                                        color: ProjectColors.secondary400,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          selectedSides.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.all(ProDesign.pt(20)),
                  child: Row(
                    children: [
                      Expanded(
                        child: ProButtonBasic(
                          width: double.infinity,
                          height: ProDesign.pt(50),
                          borderRadius: ProDesign.pt(8),
                          fontSize: ProDesign.sp(16),
                          fontColor: ProjectColors.white,
                          backgroundColor: ProjectColors.green500,
                          text: "Add to Cart",
                          onTap: () {
                            if (selectedQuantity > 0) {
                              addCheckoutModelSide(
                                ref: ref,
                                item: widget.item,
                                quantity: selectedQuantity,
                                sideList: selectedSides,
                              ).then((value) {
                                if (value == true) {
                                  showSnackBar(
                                    text: "Item added to cart.",
                                    color: ProjectColors.green500,
                                    time: 1,
                                  );
                                }
                                setState(() {
                                  selectedSides = [];
                                  selectedQuantity = 0;
                                  ref.invalidate(_selectedSidesProvider);
                                  ref.invalidate(_selectedQuantityProvider);
                                });
                              });
                            }
                          },
                        ),
                      ),
                      const Gap(x: 20),
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
                          if (selectedQuantity > 0) {
                            ref
                                .read(_selectedQuantityProvider.notifier)
                                .state--;
                          }
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
                            text: "$selectedQuantity",
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
                        backgroundColor:
                            ProjectColors.green500.withOpacity(0.15),
                        onTap: () {
                          ref.read(_selectedQuantityProvider.notifier).state++;
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
