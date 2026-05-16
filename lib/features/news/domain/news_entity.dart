class NewsEntity {
  final int id;
  final String title;
  final String excerpt;
  final String content;
  final String imageUrl;
  final DateTime date;

  NewsEntity({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imageUrl,
    required this.date,
  });
}
