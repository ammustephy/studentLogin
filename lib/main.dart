
// Put appropriate icons or images in the assets folder.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:student/StProvider/StAttendance_Provider.dart';
import 'package:student/StProvider/StAuthentication_Provider.dart';
import 'package:student/StProvider/StNews_Provider.dart';
import 'package:student/StViews/StAttendance.dart';
import 'package:student/StViews/StExamResults.dart';
import 'package:student/StViews/StHome.dart' hide AuthProvider, NewsProvider;
import 'package:student/StViews/StLogin.dart';
import 'package:student/StViews/StMarklist.dart';
import 'package:student/StViews/StNotes.dart';
import 'package:student/StViews/StNotifications.dart';
import 'package:student/StViews/StOnlineClass.dart';
import 'package:student/StViews/StProfile.dart';
import 'package:student/StViews/StSyllabus.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// Entry Point
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => NewsProvider()),
      ChangeNotifierProvider(create: (_) => AttendanceProvider()),
    ],
    child: const MyApp(),
  ));
}

// ========== MAIN APP ===========
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Academic App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
        '/attendance': (_) => const AttendancePage(),
        '/notifications': (_) => const NotificationsPage(),
        '/exam_results': (_) => const ExamResultsPage(),
        '/marklist': (_) => const MarklistPage(),
        '/syllabus': (_) => const SyllabusPage(),
        '/notes': (_) => const NotesPage(),
        '/online_classroom': (_) => const OnlineClassroomPage(),
        '/profile': (_) => const ProfilePage(),
      },
    );
  }
}
