import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:news_app/models/categories_news_models.dart';
import 'package:news_app/models/news_channels_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  static const String apiKey = 'b53455bd3edf41f19769aaf32d4cdd1d';
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(
      String newsChannel) async {
    final url = '$baseUrl/top-headlines?sources=$newsChannel&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return NewsChannelsHeadlinesModel.fromJson(body);
      } else {
        throw Exception('Failed to fetch headlines');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<CategoriesNewsModel> fetchNewsCategoriesApi(String category) async {
    final url = '$baseUrl/everything?q=$category&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return CategoriesNewsModel.fromJson(body);
      } else {
        throw Exception('Failed to fetch category news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
