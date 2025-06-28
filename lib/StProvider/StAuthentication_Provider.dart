import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/StViews/StHome.dart';
import 'package:student/StViews/StLogin.dart';

class AuthProvider extends ChangeNotifier {
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  String? _studentId;
  String? get studentId => _studentId;

  String? _error;
  String? get error => _error;

  bool _loading = false;
  bool get loading => _loading;

  Future<bool> login(String studentId, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    // Dummy validation - replace with real API call
    await Future.delayed(const Duration(seconds: 1));
    if (studentId == 'student123' && password == 'password') {
      _loggedIn = true;
      _studentId = studentId;
      _loading = false;
      notifyListeners();
      return true;
    } else {
      _error = 'Invalid student ID or password';
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _loggedIn = false;
    _studentId = null;
    notifyListeners();
  }

  String? _studentName;
  String? _studentEmail;
  String? _studentPhone;
  File? _studentPhotoFile;

  String? get studentName => _studentName;
  String? get studentEmail => _studentEmail;
  String? get studentPhone => _studentPhone;
  File? get studentPhotoFile => _studentPhotoFile;

  // Call this from your login to store initial profile info from backend:
  void setStudentDetails({
    required String name,
    required String email,
    required String phone,
    File? photoFile,
  }) {
    _studentName = name;
    _studentEmail = email;
    _studentPhone = phone;
    _studentPhotoFile = photoFile;
    notifyListeners();
  }

  // Call this from profile page on save:
  void updateProfile({
    required String name,
    required String email,
    required String phone,
    File? photoFile,
  }) {
    _studentName = name;
    _studentEmail = email;
    _studentPhone = phone;
    if (photoFile != null) _studentPhotoFile = photoFile;
    // TODO: save to backend or persistent storage
    notifyListeners();
  }
}

// ========== AUTH WRAPPER (decides login or home) ===========
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (auth.loggedIn) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
