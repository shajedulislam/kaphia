import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/utilities/functions/call_back.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/views/home/checkout_screen.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/widgets/alert.dart';

import '../../../models/charges_model.dart';
import '../../../providers/firebase.dart';
import '../../../utilities/colors.dart';
import '../../shared/widgets/loading_indicator.dart';

class ChargesLoader extends ConsumerWidget {
  const ChargesLoader({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final chargesStream = ref.watch(chargesStreamProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ProjectColors.loaderBlack,
        body: chargesStream.when(
          data: (charges) {
            if (charges != null && charges.data() != null) {
              ChargesModel chargesModel =
                  ChargesModel.fromJson(charges.data() as Map<String, dynamic>);
              callBackFunction(() {
                pop();
                push(screen: CHeckoutScreen(chargesModel: chargesModel));
              });
            } else {
              callBackFunction(() {
                pop();
                push(
                  screen: CHeckoutScreen(
                    chargesModel: ChargesModel(
                      serviceCharge: 0,
                      vat: 0,
                    ),
                  ),
                );
              });
            }

            return const SizedBox.shrink();
          },
          error: (e, s) => ProAlertClassic(
            title: "Ops!",
            titleFontSize: ProDesign.sp(18),
            message: "Something went wrong.",
            messageFontSize: ProDesign.sp(16),
            button1Text: "Ok",
            button1FontSize: ProDesign.sp(16),
            button1Function: () {
              pop();
            },
          ),
          loading: () => const NormalLoader(color: ProjectColors.white),
        ),
      ),
    );
  }
}
