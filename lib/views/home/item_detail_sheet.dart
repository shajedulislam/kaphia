import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaphia/models/menu_items.dart';
import 'package:kaphia/utilities/constants/values.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/views/shared/widgets/gap.dart';
import 'package:kaphia/views/shared/widgets/radius_clip.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../utilities/colors.dart';
import '../shared/widgets/loading_indicator.dart';

class ItemDetail extends StatefulWidget {
  final Items item;
  const ItemDetail({super.key, required this.item});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  bool sizeAvailable = false;
  bool sideAvailable = false;
  @override
  void initState() {
    if (widget.item.variationType == "size") {
      if (widget.item.sizes != null && widget.item.sizes!.isNotEmpty) {
        sizeAvailable = true;
      }
    } else if (widget.item.variationType == "side") {
      if (widget.item.sides != null && widget.item.sides!.isNotEmpty) {
        sideAvailable = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProRadiusClip(
      customBorderRadius: BorderRadius.only(
        topLeft: Radius.circular(ProDesign.pt(20)),
        topRight: Radius.circular(ProDesign.pt(20)),
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ProText(
                        text: widget.item.name,
                        fontSize: ProDesign.sp(22),
                        color: ProjectColors.secondary500,
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(x: 20),
                    ProText(
                      text:
                          "${sizeAvailable == true ? "From " : ""}${ProjectValues.currency} ${widget.item.price}",
                      fontSize: ProDesign.sp(22),
                      color: ProjectColors.secondary500,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                ProGap(y: ProDesign.pt(8)),
                ProText(
                  text: widget.item.description,
                  fontSize: ProDesign.sp(18),
                  color: ProjectColors.secondary400,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                sizeAvailable == true
                    ? Padding(
                        padding: EdgeInsets.only(top: ProDesign.pt(20)),
                        child: ProCard(
                          disableShadow: true,
                          borderRadius: ProDesign.pt(8),
                          backgroundColor:
                              ProjectColors.primary.withOpacity(0.1),
                          padding: EdgeInsets.only(
                            top: ProDesign.pt(20),
                            left: ProDesign.pt(20),
                            right: ProDesign.pt(20),
                            bottom: ProDesign.pt(0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProText(
                                text: "Sizes - Select 1",
                                fontSize: ProDesign.sp(22),
                                color: ProjectColors.secondary500,
                                fontWeight: FontWeight.w600,
                              ),
                              const Gap(y: 20),
                              Column(
                                children: widget.item.sizes!.map((size) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: ProDesign.pt(24),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ProRadioButton(
                                          radioColor: ProjectColors.primary,
                                          title: size.name,
                                          titleFontSize: ProDesign.sp(22),
                                          titleWeight: FontWeight.w500,
                                          titleColor:
                                              ProjectColors.secondary400,
                                          size: ProDesign.pt(22),
                                        ),
                                        ProText(
                                          text:
                                              "${ProjectValues.currency} ${size.price}",
                                          fontSize: ProDesign.sp(22),
                                          color: ProjectColors.secondary400,
                                          fontWeight: FontWeight.w500,
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                sideAvailable == true
                    ? Padding(
                        padding: EdgeInsets.only(top: ProDesign.pt(20)),
                        child: ProCard(
                          disableShadow: true,
                          width: double.infinity,
                          borderRadius: ProDesign.pt(8),
                          backgroundColor:
                              ProjectColors.primary.withOpacity(0.1),
                          padding: EdgeInsets.only(
                            top: ProDesign.pt(20),
                            left: ProDesign.pt(20),
                            right: ProDesign.pt(20),
                            bottom: ProDesign.pt(0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProText(
                                text:
                                    "Sides - Select any ${widget.item.sideSelectionLimit}",
                                fontSize: ProDesign.sp(22),
                                color: ProjectColors.secondary500,
                                fontWeight: FontWeight.w600,
                              ),
                              const Gap(y: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.item.sides!.map((side) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: ProDesign.pt(24)),
                                    child: ProRadioButton(
                                      radioColor: ProjectColors.primary,
                                      title: side,
                                      titleFontSize: ProDesign.sp(22),
                                      titleWeight: FontWeight.w500,
                                      titleColor: ProjectColors.secondary400,
                                      size: ProDesign.pt(22),
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
