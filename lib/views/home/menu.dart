import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/providers/firebase.dart';
import 'package:kaphia/providers/selected_menu.dart';
import 'package:kaphia/utilities/functions/call_back.dart';
import 'package:kaphia/views/shared/widgets/loading_indicator.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../utilities/colors.dart';
import '../../utilities/constants/strings.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ProDesign.pt(30),
                  horizontal: ProDesign.pt(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProText(
                      text: "Hello!",
                      fontSize: ProDesign.sp(28),
                      color: ProjectColors.secondary500,
                      fontWeight: FontWeight.w600,
                    ),
                    ProGap(y: ProDesign.pt(8)),
                    ProText(
                      text: "What would you like to order?",
                      fontSize: ProDesign.sp(18),
                      color: ProjectColors.secondary500,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ProDesign.pt(220),
                child: ListView(
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
                              padding:
                                  EdgeInsets.only(bottom: ProDesign.pt(16)),
                              child: ProRadiusClip(
                                borderRadius: ProDesign.pt(8),
                                child: ProShape(
                                  color: ProjectColors.grey300,
                                  width: ProDesign.pt(150),
                                  height: ProDesign.pt(150),
                                  radius: ProDesign.pt(8),
                                  child: CachedNetworkImage(
                                    height: ProDesign.pt(150),
                                    width: ProDesign.pt(150),
                                    fit: BoxFit.cover,
                                    imageUrl: data['image'] ?? "",
                                    placeholder: (context, url) =>
                                        const NormalLoader(),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.restaurant_menu_rounded,
                                      size: ProDesign.pt(50),
                                      color: ProjectColors.secondary400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ProDesign.pt(150),
                              child: ProText(
                                text: data['name'] ?? "NA",
                                fontSize: ProDesign.sp(18),
                                color: ProjectColors.secondary500,
                                fontWeight: FontWeight.w600,
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
