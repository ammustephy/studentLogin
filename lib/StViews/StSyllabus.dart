import 'package:flutter/material.dart';

class SyllabusPage extends StatelessWidget {
  const SyllabusPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => _simplePage(context, 'Syllabus');
}
Widget _simplePage(BuildContext context, String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text('$title page under development', style: const TextStyle(fontSize: 18))),
  );
}