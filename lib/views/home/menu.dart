import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/providers/firebase.dart';
import 'package:kaphia/providers/selected_menu.dart';
import 'package:kaphia/utilities/functions/call_back.dart';
import 'package:kaphia/views/home/home_bottom_cart.dart';
import 'package:kaphia/views/home/items.dart';
import 'package:kaphia/views/shared/widgets/loading_indicator.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../utilities/colors.dart';
import '../../utilities/constants/strings.dart';
import '../shared/widgets/gap.dart';
import '../shared/widgets/radius_clip.dart';

class Menu extends ConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final menuStream = ref.watch(menuStreamProvider);

    return menuStream.when(
      data: (menu) {
        if (menu != null && menu.docs.isNotEmpty) {
          if (ref.read(selectedMenuProvider) == null) {
            callBackFunction(() {
              ref
                  .read(selectedMenuProvider.notifier)
                  .update((state) => menu.docs.first.id);
            });
          }
          return Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: ProDesign.pt(40),
                  //     bottom: ProDesign.pt(20),
                  //     left: ProDesign.pt(20),
                  //     right: ProDesign.pt(20),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       ProText(
                  //         text: "Hello!",
                  //         fontSize: ProDesign.sp(28),
                  //         color: ProjectColors.secondary500,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //       ProGap(y: ProDesign.pt(8)),
                  //       ProText(
                  //         text: "What would you like to order?",
                  //         fontSize: ProDesign.sp(18),
                  //         color: ProjectColors.secondary500,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ProDesign.pt(60),
                      left: ProDesign.pt(20),
                      bottom: ProDesign.pt(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProText(
                          text: "Categories",
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
                  SizedBox(
                    height: ProDesign.pt(170),
                    child: ListView(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.only(
                        left: ProDesign.pt(20),
                      ),
                      scrollDirection: Axis.horizontal,
                      children: menu.docs.map((document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.only(right: ProDesign.pt(20)),
                          child: ProTapper(
                            padding: const EdgeInsets.all(0),
                            onTap: () {
                              ref
                                  .read(selectedMenuProvider.notifier)
                                  .update((state) => document.id);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: ProDesign.pt(16),
                                  ),
                                  child: ProCard(
                                    shadowBlurRadius: 10,
                                    shadowSpreadRadius: 5,
                                    shadowColor:
                                        ref.watch(selectedMenuProvider) ==
                                                document.id
                                            ? Colors.black.withOpacity(0.45)
                                            : Colors.transparent,
                                    backgroundColor: ProjectColors.grey300,
                                    width: ProDesign.pt(100),
                                    height: ProDesign.pt(100),
                                    borderRadius: ProDesign.pt(8),
                                    padding: const EdgeInsets.all(0),
                                    borderColor: ProjectColors.white,
                                    borderWidth: ProDesign.pt(1),
                                    child: ProRadiusClip(
                                      borderRadius: ProDesign.pt(8),
                                      child: CachedNetworkImage(
                                        height: ProDesign.pt(100),
                                        width: ProDesign.pt(100),
                                        fit: BoxFit.cover,
                                        imageUrl: data['image'] ?? "",
                                        placeholder: (context, url) =>
                                            const NormalLoader(),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.restaurant_menu_rounded,
                                          size: ProDesign.pt(50),
                                          color: ProjectColors.secondary400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: ProDesign.pt(100),
                                  child: ProText(
                                    text: data['name'] ?? "",
                                    fontSize: ProDesign.sp(16),
                                    color: ref.watch(selectedMenuProvider) ==
                                            document.id
                                        ? ProjectColors.primary
                                        : ProjectColors.secondary500,
                                    fontWeight:
                                        ref.watch(selectedMenuProvider) ==
                                                document.id
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    alignment: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const Expanded(child: MenuItems()),
              const HomeBottomCart()
            ],
          );
        } else {
          return Center(
            child: ProText(
              text: ProjectStrings.noDataFound,
              fontSize: ProDesign.sp(16),
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
