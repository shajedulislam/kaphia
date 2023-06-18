import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/utilities/colors.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/views/home/home_screen.dart';
import 'package:kaphia/views/shared/network_error_screen.dart';
import 'package:kaphia/views/shared/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../views/signin/signin_screen.dart';
import '../constants/enums.dart';
import 'internet_checker.dart';

Future<bool> loginMidleWear({
  required String email,
  required String password,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showSnackBar(
        text: 'User not found for this email',
        color: ProjectColors.primary,
      );
    } else if (e.code == 'wrong-password') {
      showSnackBar(
        text: 'You entered wrong password',
        color: ProjectColors.primary,
      );
    } else {
      showSnackBar(
        text: "Something went wrong",
        color: ProjectColors.primary,
      );
    }
    return false;
  } on FirebaseException catch (exp) {
    showSnackBar(
      text: exp.message ?? "Something went wrong",
      color: ProjectColors.primary,
    );
    return false;
  } catch (error) {
    showSnackBar(
      text: error.toString(),
      color: ProjectColors.primary,
    );
    return false;
  }
}

rootMiddleWear({required Flavor flavor, required WidgetRef ref}) async {
  bool networkAvailable = false;
  networkAvailable = await isNetworkAvailable();
  if (networkAvailable == true) {
    FirebaseAuth.instance.currentUser == null
        ? pushAndRemoveAll(screen: const SigninScreen())
        : pushAndRemoveAll(screen: const HomeScreen());
  } else {
    pushAndRemoveAll(screen: const NetworkErrorScreen());
  }
}
