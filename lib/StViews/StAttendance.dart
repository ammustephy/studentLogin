import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student/StProvider/StAttendance_Provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = context.watch<AttendanceProvider>();
    final periods = attendanceProvider.attendanceForDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
            lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1, 31),
            focusedDay: _selectedDate,
            selectedDayPredicate: (day) =>
                isSameDay(day, _selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                final attendance =
                attendanceProvider.attendanceForDate(date);
                if (attendance.isEmpty) {
                  return Center(child: Text('${date.day}'));
                } else {
                  final presentCount =
                      attendance.where((a) => a.present).length;
                  final absentCount = attendance.length - presentCount;
                  final color = presentCount >= absentCount
                      ? Colors.green.withOpacity(0.4)
                      : Colors.red.withOpacity(0.4);
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    margin: const EdgeInsets.all(6.0),
                    alignment: Alignment.center,
                    child: Text('${date.day}'),
                  );
                }
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: periods.isEmpty
                ? Center(
              child: Text(
                  "No attendance data for ${DateFormat('EEE, MMM d, y').format(_selectedDate)}"),
            )
                : ListView.builder(
              itemCount: periods.length,
              itemBuilder: (context, index) {
                final p = periods[index];
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(p.periodName),
                    subtitle: Text('${p.hours} hour(s)'),
                    trailing: Text(
                      p.present ? 'Present' : 'Absent',
                      style: TextStyle(
                        color: p.present ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
