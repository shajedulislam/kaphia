import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kaphia/utilities/colors.dart';
import 'package:kaphia/views/home/menu.dart';

import '../shared/widgets/snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<InternetConnectionStatus>? netWorklistener;
  bool isDisconnected = false;
  @override
  void initState() {
    netWorklistener = InternetConnectionCheckerPlus()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (isDisconnected == true) {
            isDisconnected = false;
            showSnackBar(
              text: "Internet connection restored",
              color: ProjectColors.green500,
            );
          }

          break;
        case InternetConnectionStatus.disconnected:
          isDisconnected = true;
          showSnackBar(
            text: "You are disconnected from internet",
            color: ProjectColors.primary,
          );
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    netWorklistener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ProjectColors.white,
      // appBar: AppBar(
      //   title: Padding(
      //     padding: EdgeInsets.only(left: ProDesign.pt(6)),
      //     child: ProText(
      //       text: "Kaphia",
      //       fontSize: ProDesign.sp(20),
      //       color: ProjectColors.white,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   backgroundColor: ProjectColors.secondary500,
      //   actions: [
      //     ProTapper(
      //       padding: EdgeInsets.all(ProDesign.pt(16)),
      //       onTap: () async {
      //         try {
      //           await FirebaseAuth.instance.signOut();
      //           pushAndRemoveAll(screen: const SigninScreen());
      //         } on FirebaseException catch (exp) {
      //           showSnackBar(text: exp.message ?? "Something went wrong");
      //           return false;
      //         } catch (error) {
      //           showSnackBar(text: error.toString());
      //           return false;
      //         }
      //       },
      //       child: Icon(
      //         Icons.logout,
      //         size: ProDesign.pt(24),
      //       ),
      //     )
      //   ],
      // ),
      body: Menu(),
    );
  }
}
