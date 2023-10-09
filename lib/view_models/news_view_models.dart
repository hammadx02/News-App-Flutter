import 'package:news_app/models/news_channels_headlines_model.dart';

class NewsViewModel {
  final _rep = NewsViewModel();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi() async {
    final response = await _rep.fetchNewsChannelsHeadlinesApi();
    return response;
  }
}
