import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppMultipleTabWidget<T> extends StatelessWidget {
  const AppMultipleTabWidget({
    required this.tabs,
    required this.selectedTab,
    required this.onTabSelected,
    super.key,
    this.labelBuilder,
  });

  final List<T> tabs;
  final T selectedTab;
  final void Function(T tab) onTabSelected;
  final String Function(T tab)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    if (tabs.isEmpty) {
      return const SizedBox.shrink();
    }

    const animationDuration = Duration(milliseconds: 260);
    final selectedIndex = tabs.indexOf(selectedTab).clamp(0, tabs.length - 1);
    final tabSpacing = 24.r;

    return Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.colorFFFFFF,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: AppColor.blueShadow,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalSpacing = tabSpacing * (tabs.length - 1);
          final tabWidth = (constraints.maxWidth - totalSpacing) / tabs.length;
          final left = selectedIndex * (tabWidth + tabSpacing);

          return Stack(
            children: [
              AnimatedPositioned(
                duration: animationDuration,
                curve: Curves.easeInOut,
                left: left,
                top: 0,
                bottom: 0,
                width: tabWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.color0B8AE1,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < tabs.length; i++) ...[
                    if (i > 0) SizedBox(width: tabSpacing),
                    _filterTab(
                      selected: tabs[i] == selectedTab,
                      title: labelBuilder?.call(tabs[i]) ?? tabs[i].toString(),
                      onTap: () {
                        onTabSelected(tabs[i]);
                      },
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filterTab({
    required bool selected,
    required String title,
    void Function()? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: selected ? AppColor.colorFFFFFF : AppColor.color0B8AE1,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
