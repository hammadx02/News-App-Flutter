import 'package:news_app/models/categories_news_models.dart';
import 'package:news_app/models/news_channels_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(String channelName) async {
    final response = await _rep.fetchNewsChannelsHeadlinesApi(channelName);
    return response;
  }

   Future<CategoriesNewsModel> fetchNewsCategoriesApi(String category) async {
    final response = await _rep.fetchNewsCategoriesApi(category);
    return response;
  }
}
