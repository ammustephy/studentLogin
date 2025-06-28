import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  final List<String> _news = [
    'School reopens from 1st July',
    'Science Fair on 15th July',
    'Parent-Teacher Meeting on last Saturday',
    'New library books available now',
  ];

  List<String> get news => _news;
}