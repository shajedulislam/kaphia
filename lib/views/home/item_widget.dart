import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaphia/models/menu_items.dart';
import 'package:kaphia/views/home/item_detail_size_variation.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../utilities/colors.dart';
import '../../utilities/constants/values.dart';
import '../../utilities/functions/navigation.dart';
import '../shared/widgets/loading_indicator.dart';
import '../shared/widgets/radius_clip.dart';
import 'item_detail_sheet.dart';
import 'item_detail_side_variation.dart';

class ItemWidget extends StatelessWidget {
  final Items item;
  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ProDesign.pt(20)),
      child: ProTapper(
        padding: const EdgeInsets.all(0),
        onTap: () {
          proBottomSheet(
              context: context,
              customAppBar: const SizedBox.shrink(),
              isScrollControlled: true,
              sheetHeight: ProDesign.vertically(100),
              sheetMargin: EdgeInsets.only(
                top: ProDesign.vertically(8),
              ),
              sheetBackgroundColor: ProjectColors.white,
              onAppBarCloseIconTap: () {
                pop();
              },
              customBorderRadius: BorderRadius.only(
                topLeft: Radius.circular(ProDesign.pt(20)),
                topRight: Radius.circular(ProDesign.pt(20)),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
              sheetBody: item.variationType == "size"
                  ? ItemDetailSizeVariation(item: item)
                  : item.variationType == "side"
                      ? ItemDetailSideVariation(
                          item: item,
                        )
                      : ItemDetail(item: item));
        },
        child: ProCard(
          backgroundColor: ProjectColors.grey200,
          disableShadow: true,
          width: double.infinity,
          height: ProDesign.pt(140),
          padding: EdgeInsets.all(ProDesign.pt(20)),
          borderRadius: ProDesign.pt(8),
          child: Row(
            children: [
              ProCard(
                backgroundColor: ProjectColors.grey300,
                width: ProDesign.pt(100),
                height: ProDesign.pt(100),
                borderRadius: ProDesign.pt(8),
                padding: const EdgeInsets.all(0),
                borderColor: ProjectColors.grey300,
                borderWidth: ProDesign.pt(1),
                child: ProRadiusClip(
                  borderRadius: ProDesign.pt(8),
                  child: CachedNetworkImage(
                    height: ProDesign.pt(150),
                    width: ProDesign.pt(150),
                    fit: BoxFit.cover,
                    imageUrl: item.image ?? "",
                    placeholder: (context, url) => const NormalLoader(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.fastfood,
                      size: ProDesign.pt(50),
                      color: ProjectColors.secondary400,
                    ),
                  ),
                ),
              ),
              ProGap(x: ProDesign.pt(20)),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProText(
                    text: "${ProjectValues.currencySymbol} ${item.price}",
                    fontSize: ProDesign.sp(18),
                    color: ProjectColors.green500,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProText(
                        text: item.name,
                        fontSize: ProDesign.sp(18),
                        color: ProjectColors.secondary500,
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      ProGap(y: ProDesign.pt(8)),
                      ProText(
                        text: item.description,
                        fontSize: ProDesign.sp(16),
                        color: ProjectColors.secondary400,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
