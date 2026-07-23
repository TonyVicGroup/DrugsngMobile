import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({required this.details, super.key});

  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    final errorMessage = details.exceptionAsString();
    final hasNavigator = Navigator.of(context, rootNavigator: true).canPop();

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420.w),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24.r),
                      // border: Border.all(
                      //   color: extraColors.primaryOutline.withOpacity(0.2),
                      //   width: 1.w,
                      // ),
                    ),
                    padding: EdgeInsets.fromLTRB(20.w, 70.h, 20.w, 20.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 18.h),
                        Container(
                          width: 84.r,
                          height: 84.r,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.error_outline_rounded,
                            size: 42.r,
                            color: Colors.red,
                          ),
                        ),
                        18.verticalSpace,
                        Text(
                          'Something went wrong',
                          textAlign: TextAlign.center,
                          // style: context.h5.copyWith(
                          //   fontWeight: FontWeight.w800,
                          //   color: extraColors.solidText,
                          // ),
                        ),
                        10.verticalSpace,
                        Text(
                          kDebugMode
                              ? errorMessage
                              : 'An unexpected error occurred and has been reported. Please restart the app.',
                          textAlign: TextAlign.center,
                          // style: context.h7.copyWith(
                          //   color: extraColors.solidText.withOpacity(0.75),
                          //   fontWeight: FontWeight.w500,
                          // ),
                        ),
                        if (kDebugMode) ...[
                          16.verticalSpace,
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Text(
                              errorMessage,
                              // style: context.h8.copyWith(
                              //   color: extraColors.solidText,
                              // ),
                            ),
                          ),
                        ],
                        20.verticalSpace,
                        // AppFilledButton(
                        //   title: hasNavigator ? 'Close' : 'Okay',
                        //   onTap: () {
                        //     if (hasNavigator) {
                        //       Navigator.of(context).maybePop();
                        //     }
                        //   },
                        //   gradient: extraColors.primaryGradient,
                        //   borderColor: extraColors.primaryOutline,
                        //   textColor: theme.colorScheme.onPrimary,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
