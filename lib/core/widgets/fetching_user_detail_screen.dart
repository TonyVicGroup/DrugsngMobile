import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/features/navigation/presentation/pages/tab_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FetchingUserDetailScreen extends StatefulWidget {
  const FetchingUserDetailScreen({super.key});

  @override
  State<FetchingUserDetailScreen> createState() =>
      _FetchingUserDetailScreenState();
}

class _FetchingUserDetailScreenState extends State<FetchingUserDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if user is not logged in trigger token login
      context.read<AuthCubit>().tokenLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, __) => context.isOnScreen,
      listener: (context, state) {
        if (!state.isLoggedIn) {
          AppToast.warning(context, state.error ?? 'Session expired');
          AppUtils.navKey.currentState?.pushAndRemoveUntil(
            AppUtils.transition(const LoginPage()),
            (route) => false,
          );
        } else {
          AppUtils.navKey.currentState?.pushAndRemoveUntil(
            AppUtils.transition(const TabOverlay()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(AppImage.logo, height: 20.r),
                20.verticalSpace,
                AppText.sp20('Drugs.NG').w700.primaryColor,
                40.verticalSpace,
                SizedBox(
                  width: 50.r,
                  height: 50.r,
                  child: CircularProgressIndicator(
                    color: AppColor.primary,
                    strokeWidth: 3,
                  ),
                ),
                20.verticalSpace,
                AppText.sp14('Fetching account information...').w500.subText,
                5.verticalSpace,
                AppText.sp12('Please wait a moment').w400.lightGrey,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
