import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String get timeDifference {
    final now = DateTime.now();
    final difference = now.difference(this);

    // Format time as hour:minutes (e.g., 3:45 PM)
    final timeFormat = DateFormat('h:mm a').format(this);

    if (difference.inDays == 0 && now.day == day) {
      // The date is today
      return 'Today, $timeFormat';
    } else if (difference.inDays.abs() == 1) {
      // The date is yesterday or tomorrow
      return difference.isNegative
          ? 'Tomorrow, $timeFormat'
          : 'Yesterday, $timeFormat';
    } else if (difference.inDays.abs() < 7) {
      // Within the same week
      final dayOfWeek = DateFormat('EEEE').format(this); // e.g., "Monday"
      return '$dayOfWeek, $timeFormat';
    } else if (difference.inDays.abs() < 30) {
      // Within the same month
      final weeks = (difference.inDays.abs() / 7).ceil();
      return difference.isNegative
          ? 'In $weeks week${weeks > 1 ? 's' : ''}, $timeFormat'
          : '$weeks week${weeks > 1 ? 's' : ''} ago, $timeFormat';
    } else {
      // Default to full date for anything else
      final dateFormat = DateFormat(
        'MMMM d, yyyy',
      ); // e.g., "November 18, 2024"
      return '${dateFormat.format(this)} at $timeFormat';
    }
  }
}
