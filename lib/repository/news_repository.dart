import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_channels_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=35a778b7c85a46418b137cafe2d8bd59';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
