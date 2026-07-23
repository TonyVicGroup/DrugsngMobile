import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/extensions/string_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/features/consultation/data/models/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

final DateTime _oldesttimeConst = DateTime(1100);

class CustomDatePicker extends StatefulWidget {
  final DateTime currentDate;
  final DateTime? lastDate;
  final DateTime? selectedDay;
  final Set<int> unAvailableWeekdays;
  final void Function(DateTime) onChanged;
  CustomDatePicker({
    super.key,
    required this.currentDate,
    this.lastDate,
    this.selectedDay,
    required this.onChanged,
    required this.unAvailableWeekdays,
  }) : assert(currentDate.isAfter(lastDate ?? _oldesttimeConst));

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late ValueNotifier<DateTime> month;
  List<CalendarDay> days = [];

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDay;
    month = ValueNotifier<DateTime>(
      DateTime(widget.currentDate.year, widget.currentDate.month),
    );
    month.addListener(() {
      _loadDays();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadDays();
    });
  }

  _loadDays() {
    days = CalendarService.generateMonthDays(
      month.value.month,
      month.value.year,
      widget.unAvailableWeekdays,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B3B50).withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 8.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              backButton(true),
              const Spacer(),
              _monthDropdown(),
              4.horizontalSpace,
              _yearDropdown(),
              const Spacer(),
              backButton(false),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                ...WeekdayEnum.values.map(
                  (e) => Expanded(
                    child:
                        AppText.sp18(
                          e.name.capitalize,
                        ).w500.setColor(const Color(0xFF212B36)).centerText,
                  ),
                ),
              ],
            ),
          ),
          11.verticalSpace,
          GridView.builder(
            itemCount: days.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemBuilder: (context, index) {
              return _dayTile(days[index]);
            },
          ),
        ],
      ),
    );
  }

  Container _yearDropdown() {
    return Container(
      width: 85.w,
      height: 44.h,
      // padding: EdgeInsets.symmetric(horizontal: 6.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        // border: Border.all(color: AppColor.primary),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000E33).withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: DropdownButton<int>(
        value: month.value.year,
        underline: const SizedBox.shrink(),
        icon: const SizedBox.shrink(),
        isExpanded: true,
        items: List.generate(20, (index) {
          final year = DateTime.now().year + index;
          return DropdownMenuItem(
            alignment: AlignmentDirectional.center,
            value: year,
            child: AppText.sp18(year.toString()).w600.centerText,
          );
        }),
        onChanged: (v) {
          month.value = DateTime(v ?? month.value.year);
        },
      ),
    );
  }

  Container _monthDropdown() {
    return Container(
      width: 85.w,
      height: 44.h,
      // padding: EdgeInsets.symmetric(horizontal: 6.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColor.primary, width: 2),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000E33).withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: DropdownButton<int>(
        value: month.value.month,
        underline: const SizedBox.shrink(),
        icon: const SizedBox.shrink(),
        isExpanded: true,
        items: List.generate(
          12,
          (index) => DropdownMenuItem(
            alignment: AlignmentDirectional.center,
            value: index + 1,
            child:
                AppText.sp18(
                  DateFormat(
                    'MMM',
                  ).format(DateTime(month.value.year, index + 1)),
                ).w600.centerText,
          ),
        ),
        onChanged: (v) {
          selectedDate = null;
          month.value = DateTime(month.value.year, v ?? month.value.month);
        },
      ),
    );
  }

  Widget _dayTile(CalendarDay calDay) {
    bool selected = sameDay(calDay.day, selectedDate ?? _oldesttimeConst);
    return InkWell(
      onTap: () {
        if (calDay.isMonth) {
          if (calDay.available) {
            setState(() {
              selectedDate = calDay.day;
            });
            _selected(calDay.day);
          }
        } else {
          AppToast.info(context, 'Doctor is not available today');
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: selected ? AppColor.primary : AppColor.white,
          boxShadow:
              (calDay.isMonth && calDay.available)
                  ? [
                    BoxShadow(
                      color: const Color(0xFF000E33).withOpacity(0.05),
                      offset: const Offset(0, 1),
                      blurRadius: 1,
                    ),
                  ]
                  : null,
        ),
        child: Text(
          calDay.day.day.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color:
                (calDay.isMonth && calDay.available)
                    ? (selected ? AppColor.white : const Color(0xFF212B36))
                    : const Color(0xFF212B36).withOpacity(0.15),
          ),
        ),
      ),
    );
  }

  Widget backButton(bool back) {
    return InkWell(
      onTap: () {
        if (back) {
          _prevMonth();
        } else {
          _nextMonth();
        }
      },
      child: Container(
        width: 44.r,
        height: 44.r,
        margin: EdgeInsets.all(12.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF9F9F9),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000E33).withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: RotatedBox(
          quarterTurns: back ? 0 : 2,
          child: SvgPicture.asset(
            AppSvg.chevronThick,
            width: 10.r,
            colorFilter: const ColorFilter.mode(
              AppColor.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  void _selected(DateTime day) async {
    widget.onChanged(day);
  }

  void _nextMonth() {
    month.value = DateTime(month.value.year, month.value.month + 1);
  }

  void _prevMonth() {
    month.value = DateTime(month.value.year, month.value.month - 1);
  }

  bool sameDay(DateTime day1, DateTime day2) {
    return (day1.day == day2.day) &&
        (day1.month == day2.month) &&
        (day1.year == day2.year);
  }
}
