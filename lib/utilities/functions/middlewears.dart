import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/views/home/home_screen.dart';
import 'package:kaphia/views/shared/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../views/signin/signin_screen.dart';
import '../constants/enums.dart';
import '../constants/strings.dart';
import 'internet_checker.dart';

Future<bool> loginMidleWear({
  required String email,
  required String password,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseException catch (exp) {
    showSnackBar(text: exp.message ?? "Something went wrong");
    return false;
  } catch (error) {
    showSnackBar(text: error.toString());
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
    showSnackBar(text: ProjectStrings.internetConnection);
  }
}
