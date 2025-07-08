import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/StProvider/StAttendance_Provider.dart';
import 'package:student/StProvider/StAuthentication_Provider.dart';
import 'package:student/StProvider/StNews_Provider.dart';
import 'package:student/StViews/StAttendance.dart';
import 'package:student/StViews/StBusDetails.dart';
import 'package:student/StViews/StExamResults.dart';
import 'package:student/StViews/StHome.dart';
import 'package:student/StViews/StLogin.dart';
import 'package:student/StViews/StMarklist.dart';
import 'package:student/StViews/StNotes.dart';
import 'package:student/StViews/StNotifications.dart';
import 'package:student/StViews/StOnlineClass.dart';
import 'package:student/StViews/StPayments.dart';
import 'package:student/StViews/StProfile.dart';
import 'package:student/StViews/StSyllabus.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Student Academic App',
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
          '/attendance': (_) => const AttendancePage(),
          '/notifications': (_) => const NotificationsPage(),
          '/exam_results': (_) => const ExamResultsPage(),
          '/marklist': (_) =>  MarklistPage(),
          '/syllabus': (_) =>  SyllabusPage(),
          '/notes': (_) => const NotesPage(),
          '/online_classroom': (_) => const OnlineClassroomPage(),
          '/profile': (_) => const ProfilePage(),
          '/bus': (_) => const BusListPage(),
          '/payments': (_) => const OnlinePaymentPage(),
        },
      ),
    );
  }
}
