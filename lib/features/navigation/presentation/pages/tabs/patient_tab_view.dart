import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientTabView extends StatelessWidget {
  const PatientTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: TabBarView(
              controller: AppUtils.tabController,
              children: [Container(), Container(), Container(), Container()],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 99.h,
              alignment: Alignment.center,
              child: Container(
                height: 72.h,
                width: 398.w,
                decoration: BoxDecoration(
                  color: AppColor.colorFFFFFF,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.color0B8AE1.withAlpha(35),
                      blurRadius: 20.r,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 15.w,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 75.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColor.colorE1F2FA,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
