
////USING DIO/////////////////////////////////////////////////////////////////


import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  late final Dio dio;

  ApiService._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://<YOUR_BACKEND_IP>:5000/api/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    )
    );

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    dio.interceptors.add(InterceptorsWrapper(onError: (e, handler) {
      if (e.response?.statusCode == 401) {
        // handle token refresh or redirect to login
      }
      handler.next(e);
    }));
  }

  Future<Map<String, dynamic>> fetchAttendances() async {
    final res = await dio.get('attendances');
    return res.data;
  }

  Future<Map<String, dynamic>> fetchNews() async {
    final res = await dio.get('news');
    return res.data;
  }
}


/////////////////////////////////////////////////////////////////////////////////////////
//// lib/StProvider/StNews_Provider.dart
// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
//
// class NewsProvider extends ChangeNotifier {
//   List<Map<String, dynamic>> news = [];
//   bool isLoading = false;
//
//   Future<void> loadNews() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final data = await ApiService().fetchNews();
//       news = List<Map<String, dynamic>>.from(data['items'] ?? []);
//     } catch (e) {
//       debugPrint('Error loading news: $e');
//     }
//     isLoading = false;
//     notifyListeners();
//   }
// }

///////////////////////////////////////////////////////////////
//// lib/StProvider/StAttendance_Provider.dart
// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
//
// class AttendanceProvider extends ChangeNotifier {
//   List<Map<String, dynamic>> attendances = [];
//   bool isLoading = false;
//
//   Future<void> loadAttendance() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final data = await ApiService().fetchAttendances();
//       attendances = List<Map<String, dynamic>>.from(data['records'] ?? []);
//     } catch (e) {
//       debugPrint('Error loading attendance: $e');
//     }
//     isLoading = false;
//     notifyListeners();
//   }
// }


///////////////////////////////////////////////////////////////////////////////////
//@override
// void initState() {
//   super.initState();
//   Provider.of<NewsProvider>(context, listen: false).loadNews();
// }
//
// @override
// Widget build(BuildContext context) {
//   final newsProv = Provider.of<NewsProvider>(context);
//   return newsProv.isLoading
//       ? CircularProgressIndicator()
//       : ListView.builder(
//           itemCount: newsProv.news.length,
//           itemBuilder: (ctx, i) {
//             final item = newsProv.news[i];
//             return ListTile(
//               title: Text(item['title'] ?? ''),
//               subtitle: Text(item['summary'] ?? ''),
//             );
//           },
//         );
// }