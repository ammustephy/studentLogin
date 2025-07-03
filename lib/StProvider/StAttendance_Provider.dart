import 'package:flutter/material.dart';

class AttendanceProvider extends ChangeNotifier {
  final Map<DateTime, List<PeriodAttendance>> _attendanceByDate = {};

  AttendanceProvider();

  /// Return attendance list for a specific date (day accuracy).
  List<PeriodAttendance> attendanceForDate(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    return _attendanceByDate[dateOnly] ?? [];
  }

  /// Asynchronously load attendance data for the entire month of [month].
  /// Simulates delay; replace with real API or DB call.
  Future<void> loadAttendanceForMonth(DateTime month) async {
    final start = DateTime(month.year, month.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(start.year, start.month);

    // Simulate network or database delay
    await Future.delayed(const Duration(milliseconds: 800));

    for (int d = 1; d <= daysInMonth; d++) {
      final date = DateTime(start.year, start.month, d);
      if (date.weekday >= DateTime.monday && date.weekday <= DateTime.friday) {
        final periods = List.generate(6, (i) {
          final present = (i + d) % 3 != 0; // sample pattern for present/absent
          return PeriodAttendance(
            periodName: 'Period ${i + 1}',
            hours: 1,
            present: present,
          );
        });
        _attendanceByDate[date] = periods;
      } else {
        // No periods on weekends
        _attendanceByDate[date] = [];
      }
    }
    notifyListeners();
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