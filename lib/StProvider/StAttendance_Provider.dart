import 'package:flutter/material.dart';

class AttendanceProvider extends ChangeNotifier {
  // key: DateTime (date only), value: list of period attendances
  final Map<DateTime, List<PeriodAttendance>> _attendanceByDate = {};

  AttendanceProvider() {
    _loadDummyData();
  }

  List<PeriodAttendance> attendanceForDate(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    return _attendanceByDate[dateOnly] ?? [];
  }

  List<DateTime> get availableDates =>
      _attendanceByDate.keys.toList()..sort((a, b) => a.compareTo(b));

  void _loadDummyData() {
    // Let's create dummy attendance data for June 2024, weekdays only
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(startDate.year, startDate.month);

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(startDate.year, startDate.month, day);
      if (date.weekday >= DateTime.monday && date.weekday <= DateTime.friday) {
        final periods = List.generate(6, (index) {
          // Randomly mark Present or Absent for demo
          final present = (index + day) % 3 != 0;
          return PeriodAttendance(
            periodName: 'Period ${index + 1}',
            hours: 1,
            present: present,
          );
        });
        _attendanceByDate[date] = periods;
      }
    }
  }
}

class PeriodAttendance {
  final String periodName;
  final int hours;
  final bool present;

  PeriodAttendance({
    required this.periodName,
    required this.hours,
    required this.present,
  });
}
