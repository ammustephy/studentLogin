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
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadMonth(_focusedDay);
  }

  Future<void> _loadMonth(DateTime month) async {
    setState(() => _loading = true);
    await context.read<AttendanceProvider>().loadAttendanceForMonth(month);
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AttendanceProvider>();
    final today = DateTime.now();
    final selected = _selectedDate ?? _focusedDay;
    final periods = provider.attendanceForDate(selected);

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: SafeArea(
        child: Column(
          children: [
            if (_loading) const LinearProgressIndicator(),

            // Fixed-height calendar
            SizedBox(
              height: 350,
              child: TableCalendar<PeriodAttendance>(
                firstDay: DateTime(today.year, today.month - 12, 1),
                lastDay: today,
                focusedDay: _focusedDay.isAfter(today) ? today : _focusedDay,
                selectedDayPredicate: (d) => isSameDay(d, _selectedDate),
                onDaySelected: (sel, foc) {
                  if (sel.isAfter(today)) return;
                  setState(() {
                    _selectedDate = sel;
                    _focusedDay = foc;
                  });
                },
                onPageChanged: (foc) async {
                  if (foc.isAfter(today)) return;
                  setState(() {
                    _focusedDay = foc;
                    _selectedDate ??= foc;
                  });
                  await _loadMonth(foc);
                },
                eventLoader: provider.attendanceForDate,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (ctx, date, events) {
                    if (date.isAfter(today) || events.isEmpty) return null;
                    final present = events.where((e) => e.present).length;
                    final absent = events.length - present;
                    final color = present >= absent
                        ? Colors.green.withOpacity(0.4)
                        : Colors.red.withOpacity(0.4);
                    return Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                      alignment: Alignment.center,
                      child: Text('${date.day}', style: const TextStyle(color: Colors.white)),
                    );
                  },
                ),
              ),
            ),

            const Divider(),

            // Flexible attendance list below
            Expanded(
              child: periods.isEmpty
                  ? Center(
                child: Text(
                  "No data for ${DateFormat('EEE, MMM d, y').format(selected)}",
                  textAlign: TextAlign.center,
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: periods.length,
                itemBuilder: (_, i) {
                  final p = periods[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
      ),
    );
  }
}
