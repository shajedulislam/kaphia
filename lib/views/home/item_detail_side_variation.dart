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
  bool itemInCart = false;
  final _selectedSidesProvider =
      StateProvider.autoDispose<List<String>?>((ref) {
    return [];
  });
  List<String> selectedSides = [];
  @override
  void initState() {
    List<CheckoutOrderItems>? orderItems =
        ref.read(checkoutModelProvider).orderItems;
    if (orderItems != null && orderItems.isNotEmpty) {
      for (var element in orderItems) {
        if (element.id == widget.item.id) {
          setState(() {
            itemInCart = true;
            selectedSides = element.sides ?? [];
          });

          break;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CheckoutModel checkoutModel = ref.watch(checkoutModelProvider);
    if (itemInCart != true) {
      selectedSides = ref.watch(_selectedSidesProvider) ?? [];
    }
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
                  child: ProButtonBasic(
                    width: double.infinity,
                    height: ProDesign.pt(61),
                    borderRadius: ProDesign.pt(8),
                    fontSize: ProDesign.sp(16),
                    fontColor: ProjectColors.white,
                    backgroundColor: itemInCart != true
                        ? ProjectColors.green500
                        : ProjectColors.red500,
                    text:
                        itemInCart != true ? "Add to Cart" : "Remove from Cart",
                    onTap: () {
                      if (itemInCart != true) {
                        addCheckoutModelSide(
                                ref: ref,
                                item: widget.item,
                                sideList: selectedSides)
                            .then((value) {
                          if (value == true) {
                            pop();
                          } else {
                            setState(() {
                              selectedSides = [];
                              itemInCart = false;
                              ref.invalidate(_selectedSidesProvider);
                            });
                          }
                        });
                      } else {
                        if (widget.item.id != null) {
                          removeCheckoutModelSide(ref: ref, id: widget.item.id!)
                              .then((value) {
                            setState(() {
                              selectedSides = [];
                              itemInCart = false;
                              ref.invalidate(_selectedSidesProvider);
                            });
                          });
                        }
                      }
                    },
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
