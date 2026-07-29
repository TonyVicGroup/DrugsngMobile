import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMultipleTabWidget<T> extends StatelessWidget {
  const CustomMultipleTabWidget({
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
      height: 40.h,
      decoration: BoxDecoration(
        color: const Color(0x0D101828),
        borderRadius: BorderRadius.circular(12.r),
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
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.r),
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
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.grey[600],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
