import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/models/menu_items.dart';
import 'package:kaphia/views/home/item_widget.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../providers/firebase.dart';
import '../../utilities/colors.dart';
import '../../utilities/constants/strings.dart';
import '../shared/widgets/gap.dart';
import '../shared/widgets/loading_indicator.dart';

class MenuItems extends ConsumerWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final itemsStream = ref.watch(menuItemsStreamProvider);
    return itemsStream.when(
      data: (itemDocument) {
        if (itemDocument != null && itemDocument.data() != null) {
          MenuItemsModel menuItemsModel = MenuItemsModel.fromJson(
              itemDocument.data() as Map<String, dynamic>);

          return menuItemsModel.availability == true
              ? menuItemsModel.items != null && menuItemsModel.items!.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: ProDesign.pt(20),
                            bottom: ProDesign.pt(0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProText(
                                text: "${menuItemsModel.name} Items",
                                fontSize: ProDesign.sp(24),
                                color: ProjectColors.secondary500,
                                fontWeight: FontWeight.w600,
                              ),
                              const Gap(y: 15),
                              ProDivider(
                                width: double.infinity,
                                color: ProjectColors.secondary200,
                                height: ProDesign.pt(1),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.all(ProDesign.pt(20)),
                            itemCount: menuItemsModel.items?.length,
                            itemBuilder: (context, index) {
                              Items? item = menuItemsModel.items![index];
                              return ItemWidget(item: item);
                            },
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: ProText(
                        text: ProjectStrings.noItems,
                        fontSize: ProDesign.sp(18),
                        color: ProjectColors.secondary500,
                        fontWeight: FontWeight.bold,
                      ),
                    )
              : Center(
                  child: ProText(
                    text: ProjectStrings.notAvailable,
                    fontSize: ProDesign.sp(18),
                    color: ProjectColors.secondary500,
                    fontWeight: FontWeight.bold,
                  ),
                );
        } else {
          return Center(
            child: ProText(
              text: ProjectStrings.noDataFound,
              fontSize: ProDesign.sp(18),
              color: ProjectColors.secondary500,
              fontWeight: FontWeight.bold,
            ),
          );
        }
      },
      error: (e, s) => Center(
        child: ProText(
          text: ProjectStrings.wentWrong,
          fontSize: ProDesign.sp(16),
          color: ProjectColors.secondary500,
          fontWeight: FontWeight.bold,
        ),
      ),
      loading: () => const NormalLoader(),
    );
  }
}
