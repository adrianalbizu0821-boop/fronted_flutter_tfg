import '../domain/news_repository.dart';
import '../domain/news_entity.dart';
import 'news_remote_datasource.dart';
//Implementa el repositorio usando el datasource 
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
//Conecta domain con data 
  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<NewsEntity>> getNewsList() {
    return remoteDataSource.getNewsList();
  }

  @override
  Future<NewsEntity> getNewsById(int id) {
    return remoteDataSource.getNewsById(id);
  }
}
