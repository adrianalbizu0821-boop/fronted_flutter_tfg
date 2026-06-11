import 'package:flutter/material.dart';
import 'package:fronted_flutter_tfg/features/news/data/news_remote_datasource.dart';
import 'package:fronted_flutter_tfg/features/news/data/news_repository_impl.dart';
import 'package:fronted_flutter_tfg/features/news/domain/get_news_usecase.dart';
import 'package:fronted_flutter_tfg/features/news/domain/news_entity.dart';
import 'package:fronted_flutter_tfg/core/routes/app_routes.dart';
import 'package:flutter/foundation.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<NewsEntity>> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadNews();
  }

  Future<List<NewsEntity>> _loadNews() async {
    final datasource = NewsRemoteDataSource();
    final repository = NewsRepositoryImpl(datasource);
    final usecase = GetNewsUseCase(repository);
    return usecase();
  }

  void _retry() {
    setState(() {
      _future = _loadNews();
    });
  }

  String _formatDate(DateTime d) {
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    final year = d.year.toString();
    return '$day/$month/$year';
  }

  String _cleanHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>', multiLine: true), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#8217;', '’')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Noticias')),
      body: FutureBuilder<List<NewsEntity>>(
        future: _future,
        builder: (context, snapshot) {
          // Loader con skeletons
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _NewsSkeletonList();
          }

          // Error con reintento
          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No se pudieron cargar las noticias'),
                ),
              );
            });
            return _ErrorState(onRetry: _retry);
          }

          final newsList = snapshot.data ?? [];

          // Estado vacío
          if (newsList.isEmpty) {
            return _EmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async => _retry(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: newsList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final n = newsList[index];
                return _NewsCard(
                  title: n.title,
                  date: _formatDate(n.date),
                  excerpt: _cleanHtml(n.excerpt),
                  imageUrl: n.imageUrl,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.newsDetail,
                      arguments: n,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final String title;
  final String date;
  final String excerpt;
  final String imageUrl;
  final VoidCallback onTap;

  const _NewsCard({
    required this.title,
    required this.date,
    required this.excerpt,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl.isNotEmpty;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen 16:9
            AspectRatio(
              aspectRatio: 16 / 9,
              child: kIsWeb
                  ? const _ImagePlaceholder()
                  : hasImage
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const _ImagePlaceholder(),
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return _ImageShimmer();
                      },
                    )
                  : const _ImagePlaceholder(),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fecha
                  Text(
                    date,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                  const SizedBox(height: 6),

                  // Título
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),

                  // Extracto
                  Text(
                    excerpt,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 56, color: Colors.white70),
      ),
    );
  }
}

class _ImageShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _NewsSkeletonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) => _NewsSkeletonCard(),
    );
  }
}

class _NewsSkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Bloque imagen
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(color: Colors.grey.shade200),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _SkeletonBar(width: 80),
                SizedBox(height: 8),
                _SkeletonBar(width: double.infinity),
                SizedBox(height: 6),
                _SkeletonBar(width: double.infinity),
                SizedBox(height: 6),
                _SkeletonBar(width: 180),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonBar extends StatelessWidget {
  final double width;
  const _SkeletonBar({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 48, color: Colors.black45),
            const SizedBox(height: 12),
            Text(
              'No se pudieron cargar las noticias',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.article_outlined, size: 48, color: Colors.black45),
            const SizedBox(height: 12),
            Text(
              'No hay noticias disponibles por el momento.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
