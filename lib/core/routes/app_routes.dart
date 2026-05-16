import 'package:flutter/material.dart';
import 'package:fronted_flutter_tfg/core/navegacion/home_page.dart';
import 'package:fronted_flutter_tfg/features/news/presentation/pages/news_detail_page.dart';
import 'package:fronted_flutter_tfg/features/notification/notification_page.dart';
import 'package:fronted_flutter_tfg/features/news/domain/news_entity.dart';

class AppRoutes {
  static const String home = '/';
  static const String newsDetail = '/news-detail';
  static const String notificationConsent = '/notification-consent';

  static Map<String, WidgetBuilder> get routes {
  return {
    home: (context) => const HomePage(),
    notificationConsent: (context) => const NotificationPage(),
  };
}
static Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case newsDetail:
      final news = settings.arguments as NewsEntity;
      return MaterialPageRoute(
        builder: (_) => NewsDetailPage(news: news),
      );
  }
  return null;
}
}
