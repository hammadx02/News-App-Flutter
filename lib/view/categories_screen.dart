import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../view_models/news_view_models.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MM, dd, yyyy');
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
