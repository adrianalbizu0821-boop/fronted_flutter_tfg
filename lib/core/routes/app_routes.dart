import 'package:flutter/material.dart';
import 'package:fronted_flutter_tfg/core/navegacion/home_page.dart';
import 'package:fronted_flutter_tfg/features/news/presentation/pages/news_detail_page.dart';
import 'package:fronted_flutter_tfg/features/notification/notification_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String newsDetail = '/news-detail';
  static const String notificationConsent = '/notification-consent';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomePage(),
      newsDetail: (context) => const NewsDetailPage(),
      notificationConsent: (context) => const NotificationPage(),
    };
  }
}
