import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  // Common formatters
  String get ddmmyyyy => DateFormat('dd/MM/yyyy').format(this);
  String get yyyymmdd => DateFormat('yyyy-MM-dd').format(this);
  String get verboseDate => DateFormat('MMM dd, yyyy').format(this);
  String get time12h => DateFormat('hh:mm a').format(this);
  String get time24h => DateFormat('HH:mm').format(this);

  // Checks
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  // Relative time (basic)
  String get timeAgo {
    final diff = DateTime.now().difference(this);
    if (diff.inDays > 7) return verboseDate;
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }
}
