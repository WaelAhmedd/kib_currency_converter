import 'package:intl/intl.dart';

Map<String, String> getTodayAndLast7Days() {
  final DateTime today = DateTime.now();
  final DateTime sevenDaysAgo = today.subtract(const Duration(days: 7));

  final String formattedToday = DateFormat('yyyy-MM-dd').format(today);
  final String formattedSevenDaysAgo = DateFormat('yyyy-MM-dd').format(sevenDaysAgo);

  return {
    'today': formattedToday,
    'sevenDaysAgo': formattedSevenDaysAgo,
  };
}
