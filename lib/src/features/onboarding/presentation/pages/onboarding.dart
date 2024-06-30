import 'package:blur/blur.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/enter_phone_page.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
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
              width: 1.sw,
              height: 401.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.white.withOpacity(0.1),
                    AppColor.white.withOpacity(0.5),
                  ],
                ),
              ),
            ).blurred(
              blur: 40,
              colorOpacity: 0.25,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.r),
              ),
              overlay: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 0),
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
                            onTap: () => login(),
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
          ],
        ),
      ),
    );
  }

  void login() {
    AppUtils.pushReplacement(const LoginPage());
  }

  void getStarted() {
    AppUtils.push(const EnterPhonePage());
  }
}
