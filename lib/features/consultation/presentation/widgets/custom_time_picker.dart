import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTimePicker extends StatelessWidget {
  final TimeOfDay time;
  final void Function(TimeOfDay) onChanged;

  const CustomTimePicker({
    super.key,
    required this.time,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isAm = time.hour < 12;

    return Container(
      height: 165.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B3B50).withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.sp12("Select Time"),
          24.verticalSpace,
          Row(
            children: [
              InkWell(
                onTap: () async {
                  final newTime = await showTimePicker(
                    context: context,
                    initialTime: time,
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(alwaysUse24HourFormat: false),
                        child: child!,
                      );
                    },
                  );
                  if (newTime != null) {
                    onChanged(newTime);
                  }
                },
                child: Container(
                  height: 80.h,
                  width: 261.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: const Color(0xFFEAEFF5),
                  ),
                  child: Text(
                    display(),
                    style: TextStyle(
                      fontSize: 56.sp,
                      color: const Color(0xFF212B36),
                      fontFamily: AppText.fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              24.horizontalSpace,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40.r,
                    width: 53.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(4.r),
                      ),
                      border: Border.all(color: const Color(0xFFE5E5E5)),
                      color:
                          isAm
                              ? const Color(0xFFEDF8FF)
                              : const Color(0xFFEAEFF5),
                    ),
                    child: AppText.sp14("AM").w500.setColor(
                      isAm
                          ? AppColor.primary
                          : const Color(0xFF212B36).withOpacity(0.7),
                    ),
                  ),
                  Container(
                    height: 40.r,
                    width: 53.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(4.r),
                      ),
                      border: Border.all(color: const Color(0xFFE5E5E5)),
                      color:
                          (!isAm)
                              ? const Color(0xFFEDF8FF)
                              : const Color(0xFFEAEFF5),
                    ),
                    child: AppText.sp14("PM").w500.setColor(
                      (!isAm)
                          ? AppColor.primary
                          : const Color(0xFF212B36).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String display() {
    int hour = time.hour <= 12 ? time.hour : time.hour % 12;
    return "${hour.toString().padLeft(2, "0")} : ${time.minute.toString().padLeft(2, "0")}";
  }
}
