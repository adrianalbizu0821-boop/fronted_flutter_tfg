import 'package:flutter/material.dart';
import '../../features/news/presentation/pages/news_page.dart';

class AppRoutes {
  static const String home = '/';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const NewsPage(),
    };
  }
}
