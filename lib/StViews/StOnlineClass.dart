import 'package:flutter/material.dart';

class OnlineClassroomPage extends StatelessWidget {
  const OnlineClassroomPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => _simplePage(context, 'Online Classroom');
}
Widget _simplePage(BuildContext context, String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text('$title page under development', style: const TextStyle(fontSize: 18))),
  );
}