import 'dart:ui';

import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/create_account_page.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.home),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: AppColor.white.withOpacity(0.5),
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.white.withOpacity(0.2),
                    AppColor.white.withOpacity(0.5),
                  ],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImage.logo,
                            width: 35.w,
                          ),
                          5.horizontalSpace,
                          AppText.sp14("Drugs.NG").primaryColor.w700,
                        ],
                      ),
                      8.verticalSpace,
                      AppText.sp41("Your Trusted\nOnline\nPharmacy")
                          .white
                          .w500
                          .setLineHeight(1),
                      30.verticalSpace,
                      AppText.sp20(
                              "Get your medications, health products, and professional consultations all in one place. Convenient, fast, and reliable.")
                          .whiteBlue
                          .w400,
                      30.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: AppButton.primary(
                              text: "Login",
                              onTap: login,
                            ),
                          ),
                          16.horizontalSpace,
                          Expanded(
                            flex: 5,
                            child: AppButton.secondary(
                              text: "Get Started",
                              onTap: getStarted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    AppUtils.pushReplacement(const LoginPage());
  }

  void getStarted() {
    AppUtils.pushWidget(const CreateAccountPage());
  }
}
