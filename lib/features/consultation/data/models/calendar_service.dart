class CalendarService {
  static List<CalendarDay> generateMonthDays(
      int month, int year, Set<int> unAvailableWeekdays) {
    final List<CalendarDay> days = [];

    // First day of the month
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    // Last day of the month
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    // First day of the week for the first day of the month
    int startWeekday = firstDayOfMonth.weekday % 7; // Ensure Sunday is 0

    // Previous month's days
    for (int i = startWeekday - 1; i >= 0; i--) {
      DateTime prevDay = firstDayOfMonth.subtract(Duration(days: i + 1));
      days.add(CalendarDay(prevDay, false, false));
    }

    // Current month's days
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      final dt = DateTime(year, month, i);
      final bool isAvailable = !unAvailableWeekdays.contains(dt.weekday);
      days.add(CalendarDay(dt, true, isAvailable));
    }

    // Fill the remaining days of the week with the next month's days
    int remainingDays = 7 - lastDayOfMonth.weekday % 7;
    for (int i = 1; i < remainingDays; i++) {
      DateTime nextDay = lastDayOfMonth.add(Duration(days: i));
      days.add(CalendarDay(nextDay, false, false));
    }

    return days;
  }
}

enum WeekdayEnum {
  su,
  mo,
  tu,
  we,
  th,
  fr,
  sa;

  factory WeekdayEnum.fromString(String value) {
    final prefix = value.substring(0, 2).toLowerCase();

    return switch (prefix) {
      'su' => su,
      'mo' => mo,
      'tu' => tu,
      'we' => we,
      'fr' => fr,
      'sa' => sa,
      _ => mo,
    };
  }
  static List all = [su, mo, tu, we, th, fr, sa];

  int get dateTimeWeekday => switch (this) {
        su => 7,
        mo => 1,
        tu => 2,
        we => 3,
        th => 4,
        fr => 5,
        sa => 6,
      };
}

class CalendarDay {
  final DateTime day;
  final bool isMonth;
  final bool available;

  CalendarDay(this.day, this.isMonth, this.available);
}
