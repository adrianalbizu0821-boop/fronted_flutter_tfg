import 'package:flutter/material.dart';
import 'package:fronted_flutter_tfg/features/news/data/news_remote_datasource.dart';
import 'package:fronted_flutter_tfg/features/news/data/news_repository_impl.dart';
import 'package:fronted_flutter_tfg/features/news/domain/get_news_usecase.dart';
import 'package:fronted_flutter_tfg/features/news/domain/news_entity.dart';
import 'package:fronted_flutter_tfg/core/routes/app_routes.dart';
import 'package:fronted_flutter_tfg/features/settings/settings_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  Future<List<NewsEntity>> _loadNews() async {
    final datasource = NewsRemoteDataSource();
    final repository = NewsRepositoryImpl(datasource);
    final usecase = GetNewsUseCase(repository);

    return usecase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<NewsEntity>>(
        future: _loadNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar noticias'),
            );
          }

          final newsList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.newsDetail,
                    arguments: news,
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (news.imageUrl.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              news.imageUrl,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          Container(
                            height: 180,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image_not_supported, size: 60),
                          ),
                        const SizedBox(height: 12),
                        Text(
                          news.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          news.excerpt.replaceAll(RegExp(r'<[^>]*>'), ''),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
