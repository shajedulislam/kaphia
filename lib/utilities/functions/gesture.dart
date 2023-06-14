import 'package:flutter/material.dart';

unFocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}

// void hideKeyboard(BuildContext context) {
//   FocusScopeNode currentFocus = FocusScope.of(context);
//   if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//     FocusManager.instance.primaryFocus?.unfocus();
//   }
// }
