import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/providers/login_button_loader.dart';
import 'package:kaphia/utilities/colors.dart';
import 'package:kaphia/utilities/functions/gesture.dart';
import 'package:kaphia/utilities/functions/middlewears.dart';
import 'package:kaphia/utilities/functions/navigation.dart';
import 'package:pro_design/pro_design.dart';
import 'package:pro_widgets/pro_widgets.dart';

import '../../utilities/functions/email_validator.dart';
import '../../utilities/functions/null_checker.dart';
import '../home/home_screen.dart';
import '../shared/widgets/loading_indicator.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late String email;
  late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: Scaffold(
        backgroundColor: ProjectColors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(ProDesign.pt(16)),
            children: [
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ProText(
                        text: "Kaphia",
                        fontSize: ProDesign.sp(34),
                        color: ProjectColors.secondary500,
                      ),
                      ProGap(y: ProDesign.pt(200)),
                      ProTextFormField(
                        width: ProDesign.pt(350),
                        paddingVertical: ProDesign.pt(20),
                        fontSize: ProDesign.sp(18),
                        fontWeight: FontWeight.w600,
                        hintFontWeight: FontWeight.w500,
                        errorFontWeight: FontWeight.w400,
                        hintFontSize: ProDesign.sp(18),
                        errorFontSize: ProDesign.sp(16),
                        fontColor: ProjectColors.secondary500,
                        hintColor: ProjectColors.secondary200,
                        hint: "Email",
                        borderRadius: ProDesign.pt(8),
                        borderColor: ProjectColors.border,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (isNull(value)) {
                            return 'Please enter your email';
                          } else if (!isEmailValid(value)) {
                            return 'PLease enter a valid email address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      ProGap(y: ProDesign.pt(16)),
                      ProTextFormField(
                        width: ProDesign.pt(350),
                        paddingVertical: ProDesign.pt(20),
                        fontSize: ProDesign.sp(18),
                        fontWeight: FontWeight.w600,
                        hintFontWeight: FontWeight.w500,
                        errorFontWeight: FontWeight.w400,
                        hintFontSize: ProDesign.sp(18),
                        errorFontSize: ProDesign.sp(16),
                        fontColor: ProjectColors.secondary500,
                        hintColor: ProjectColors.secondary200,
                        hint: "Password",
                        borderRadius: ProDesign.pt(8),
                        borderColor: ProjectColors.border,
                        obsecureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (!isNull(value)) {
                            return null;
                          } else {
                            return 'Please enter your password';
                          }
                        },
                      ),
                      ProGap(y: ProDesign.pt(16)),
                      ProButtonBasic(
                        width: ProDesign.pt(350),
                        height: ProDesign.pt(56),
                        borderRadius: ProDesign.pt(8),
                        fontSize: ProDesign.sp(16),
                        fontColor: ProjectColors.white,
                        backgroundColor: ProjectColors.primary,
                        customChild: ref.watch(loginButtonLoader) != true
                            ? ProText(
                                text: "Login",
                                fontSize: ProDesign.sp(18),
                                fontWeight: FontWeight.w700,
                                color: ProjectColors.white,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ProText(
                                    text: "Please wait",
                                    fontSize: ProDesign.sp(18),
                                    fontWeight: FontWeight.w600,
                                    color: ProjectColors.white,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: ProDesign.pt(8)),
                                    child: const NormalLoader(
                                      color: ProjectColors.white,
                                    ),
                                  )
                                ],
                              ),
                        onTap: () async {
                          if (ref.read(loginButtonLoader) != true) {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(loginButtonLoader.notifier)
                                  .update((state) => true);
                              bool loggedIn = await loginMidleWear(
                                  email: email, password: password);
                              ref
                                  .read(loginButtonLoader.notifier)
                                  .update((state) => false);

                              if (loggedIn == true) {
                                pushAndRemoveAll(screen: const HomeScreen());
                              }
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
