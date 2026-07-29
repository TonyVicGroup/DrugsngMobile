import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/navigation/domain/entities/nav_item.dart';
import 'package:drugs_ng/features/navigation/presentation/cubit/tab_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomNavBarWidget extends StatelessWidget {
  const AppBottomNavBarWidget({super.key, required this.navItems});

  final List<NavItem> navItems;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabNavigationCubit, TabNavigationState>(
      builder: (context, state) {
        return Container(
          height: 99.h,
          alignment: Alignment.center,
          child: Container(
            height: 72.h,
            width: 400.w,
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
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    alignment: Alignment((state.tabIndex / 2) - 1, 0),
                    child: Container(
                      width: 75.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColor.colorE1F2FA,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Row(
                      children: List.generate(navItems.length, (index) {
                        return _navItem(
                          navItems[index],
                          index,
                          state.tabIndex,
                          () {
                            context.read<TabNavigationCubit>().setTab(index);
                            AppUtils.tabController?.animateTo(index);
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _navItem(
    NavItem nav,
    int index,
    int selectedIndex,
    void Function() onTap,
  ) {
    final selected = index == selectedIndex;
    return Expanded(
      child: AppButtonAnimator(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              nav.svg,
              width: 23.r,
              height: 23.r,
              color: selected ? AppColor.color0B8AE1 : AppColor.color555555,
            ),
            AppText.sp11(nav.title).w500.setColor(
              selected ? AppColor.color0B8AE1 : AppColor.color555555,
            ),
          ],
        ),
      ),
    );
  }
}
