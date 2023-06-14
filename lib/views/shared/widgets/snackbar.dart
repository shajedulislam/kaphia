import 'package:flutter/material.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../../utilities/colors.dart';
import '../../../utilities/navigation.dart';
import '../../../utilities/singleton.dart';

void showSnackBar({required String text, Color? color, int? time}) {
  final ScaffoldMessengerState? scaffoldMessengerState =
      locator<NavigationService>().globalScaffoldMessengerKey.currentState;
  scaffoldMessengerState?.hideCurrentSnackBar();
  scaffoldMessengerState?.showSnackBar(
    SnackBar(
      padding: EdgeInsets.only(bottom: ProDesign.pt(8)),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: time ?? 5),
      content: ProCard(
        backgroundColor: color ?? ProjectColors.secondary500,
        borderRadius: ProDesign.pt(8),
        padding: EdgeInsets.symmetric(
          horizontal: ProDesign.pt(8),
          vertical: ProDesign.pt(16),
        ),
        shadowSpreadRadius: 2,
        shadowBlurRadius: 5,
        child: Row(
          children: [
            Expanded(
              child: ProText(
                text: text,
                fontSize: ProDesign.sp(16),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            ProGap(x: ProDesign.pt(4)),
            ProTapper(
              padding: EdgeInsets.all(ProDesign.pt(2)),
              onTap: () {
                scaffoldMessengerState.hideCurrentSnackBar();
              },
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: ProDesign.pt(24),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
