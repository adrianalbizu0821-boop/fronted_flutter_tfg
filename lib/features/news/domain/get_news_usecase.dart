import 'news_repository.dart';
import 'news_entity.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  Future<List<NewsEntity>> call() {
    return repository.getNewsList();
  }
}
