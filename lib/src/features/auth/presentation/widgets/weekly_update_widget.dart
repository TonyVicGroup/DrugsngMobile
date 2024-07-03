import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_switch.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeeklyUpdateWidget extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  const WeeklyUpdateWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSwitch.black(
          value: value,
          onChanged: onChanged,
        ),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.sp16("Weekly updates").w600.black,
              4.verticalSpace,
              AppText.sp14("Get a weekly activity report via email.")
                  .w400
                  .setColor(AppColor.black.withOpacity(0.7)),
            ],
          ),
        ),
      ],
    );
  }
}
