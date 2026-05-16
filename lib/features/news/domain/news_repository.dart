import 'news_entity.dart';

abstract class NewsRepository {
  Future<List<NewsEntity>> getNewsList();
  Future<NewsEntity> getNewsById(int id);
}
