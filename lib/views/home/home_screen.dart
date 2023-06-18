import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaphia/utilities/colors.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:kaphia/views/home/menu.dart';
import 'package:kaphia/views/signin/signin_screen.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../shared/widgets/snackbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.white,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: ProDesign.pt(6)),
          child: ProText(
            text: "Kaphia",
            fontSize: ProDesign.sp(20),
            color: ProjectColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ProjectColors.secondary500,
        actions: [
          ProTapper(
            padding: EdgeInsets.all(ProDesign.pt(16)),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                pushAndRemoveAll(screen: const SigninScreen());
              } on FirebaseException catch (exp) {
                showSnackBar(text: exp.message ?? "Something went wrong");
                return false;
              } catch (error) {
                showSnackBar(text: error.toString());
                return false;
              }
            },
            child: Icon(
              Icons.logout,
              size: ProDesign.pt(24),
            ),
          )
        ],
      ),
      body: const Menu(),
    );
  }
}
