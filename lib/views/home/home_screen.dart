import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kaphia/utilities/colors.dart';
import 'package:kaphia/utilities/functions/gesture.dart';
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
    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: const Scaffold(
        backgroundColor: ProjectColors.white,
        body: Menu(),
      ),
    );
  }
}
