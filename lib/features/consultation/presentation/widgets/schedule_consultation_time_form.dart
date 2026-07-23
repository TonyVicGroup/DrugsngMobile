import 'package:drugs_ng/features/consultation/data/models/calendar_service.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/custom_date_picker.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/custom_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleConsultationTimeForm extends StatelessWidget {
  final void Function(TimeOfDay?, DateTime?) onChanged;
  final List<Availabilities> doctorAvailability;
  final TimeOfDay timeOfDay;
  final DateTime? date;
  late Set<int> unAvailableWeekdays;
  Map<WeekdayEnum, List<TimeSlot>> timeSlots = {};

  ScheduleConsultationTimeForm({
    super.key,
    required this.onChanged,
    required this.timeOfDay,
    required this.date,
    required this.doctorAvailability,
  }) {
    if (doctorAvailability.isEmpty) {
      unAvailableWeekdays = <int>{};
    } else {
      unAvailableWeekdays = {1, 2, 3, 4, 5, 6, 7};
      for (final av in doctorAvailability) {
        final wkDay = WeekdayEnum.fromString(av.dayOfWeek);
        unAvailableWeekdays.remove(wkDay.dateTimeWeekday);
        timeSlots[wkDay] = av.timeSlots;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        20.verticalSpace,
        CustomDatePicker(
          currentDate: DateTime.now(),
          selectedDay: date,
          unAvailableWeekdays: unAvailableWeekdays,
          onChanged: (dt) {
            onChanged(null, dt);
          },
        ),
        30.verticalSpace,
        CustomTimePicker(
          time: timeOfDay,
          onChanged: (tm) {
            onChanged(tm, null);
          },
        ),
        60.verticalSpace,
      ],
    );
  }
}
