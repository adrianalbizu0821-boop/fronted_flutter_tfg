import '../../news/domain/news_entity.dart';
//Representa como llega la noticia desde Wordpress
class NewsModel extends NewsEntity {
  NewsModel({
    required int id,
    required String title,
    required String excerpt,
    required String content,
    required String imageUrl,
    required DateTime date,
  }) : super(
          id: id,
          title: title,
          excerpt: excerpt,
          content: content,
          imageUrl: imageUrl,
          date: date,
        );

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final title = json['title']?['rendered'] ?? '';
    final excerpt = json['excerpt']?['rendered'] ?? '';
    final content = json['content']?['rendered'] ?? '';

    final imageUrl = (json['yoast_head_json']?['og_image'] != null &&
            json['yoast_head_json']['og_image'] is List &&
            json['yoast_head_json']['og_image'].isNotEmpty)
        ? json['yoast_head_json']['og_image'][0]['url']
        : '';

    return NewsModel(
      id: json['id'] ?? 0,
      title: title,
      excerpt: excerpt,
      content: content,
      imageUrl: imageUrl,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }
}
