import 'dart:convert';
import 'package:http/http.dart' as http;

import 'news_model.dart';

//Aquí se hacen las llamadas HTTP reales a WordPress.
class NewsRemoteDataSource {
  static const String baseUrl =
      'https://www.trinitarias.com/wp-json/wp/v2/posts';

  Future<List<NewsModel>> getNewsList() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => NewsModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener noticias');
    }
  }

  Future<NewsModel> getNewsById(int id) async {
    final url = '$baseUrl/$id';

    print('URL: $url');

    final response = await http.get(Uri.parse(url));

    print('STATUS CODE: ${response.statusCode}');

    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return NewsModel.fromJson(data);
    } else {
      throw Exception('Error al obtener noticia por ID');
    }
  }
}
