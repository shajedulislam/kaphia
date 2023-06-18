import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/views/shared/widgets/gap.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../middlewear.dart';
import '../../providers/flavor.dart';
import '../../utilities/colors.dart';
import '../../utilities/functions/navigation.dart';

class NetworkErrorScreen extends ConsumerWidget {
  const NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: ProjectColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ProDesign.pt(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    color: ProjectColors.primary,
                    size: ProDesign.pt(24),
                  ),
                  const Gap(x: 8),
                  ProText(
                    text: "No Internet",
                    fontSize: ProDesign.sp(18),
                    fontWeight: FontWeight.w600,
                    color: ProjectColors.primary,
                  ),
                ],
              ),
              const Gap(y: 20),
              ProText(
                text: "Please check your device internet connection.",
                fontSize: ProDesign.sp(14),
                fontWeight: FontWeight.w400,
                color: ProjectColors.secondary400,
                alignment: TextAlign.center,
              ),
              const Gap(y: 60),
              ProButtonBasic(
                text: "Try Again",
                fontSize: ProDesign.sp(18),
                fontWeight: FontWeight.w700,
                backgroundColor: ProjectColors.primary,
                height: ProDesign.pt(61),
                width: ProDesign.pt(280),
                borderRadius: ProDesign.pt(8),
                onTap: () {
                  pushAndRemoveAll(
                    screen: Middlewear(flavor: ref.read(flavorStateProvider)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
