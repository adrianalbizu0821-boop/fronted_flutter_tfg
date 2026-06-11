import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../features/news/data/news_remote_datasource.dart';
import '../features/news/presentation/pages/news_detail_page.dart';
import '../main.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static bool _initialized = false;

  static Future<void> initFCM() async {
    if (_initialized) return;

    _initialized = true;

    // Notificaciones en segundo plano
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Solicitar permisos
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    // Obtener token actual
    final token = await _messaging.getToken();

    debugPrint('FCM TOKEN: $token');

    // App abierta desde notificación estando cerrada
    final initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {
      final newsId = int.tryParse(initialMessage.data['newsId'] ?? '');

      if (newsId != null) {
        await openNewsById(newsId);
      }
    }

    // Notificación recibida con app abierta
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      final title = msg.notification?.title ?? 'Nueva notificación';

      _showInAppBanner(title);
    });

    // Usuario pulsa una notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) async {
      final newsId = int.tryParse(msg.data['newsId'] ?? '');

      if (newsId != null) {
        await openNewsById(newsId);
      }
    });

    // Cambio automático de token
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      debugPrint('FCM TOKEN REFRESH: $newToken');

      // Aquí se actualiza el token en el backend
    });
  }

  static Future<void> openNewsById(int newsId) async {

  debugPrint(
    'ABRIENDO NOTICIA ID: $newsId',
  );

  try {

    final dataSource = NewsRemoteDataSource();

    final news = await dataSource.getNewsById(newsId);

    print("NOTICIA ENCONTRADA: ${news.title}");

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => NewsDetailPage(news: news),
      ),
    );

  } catch (e) {

    print("ERROR OPEN NEWS: $e");
  }
}

  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  static Future<void> deleteToken() async {
    await _messaging.deleteToken();
  }

  static void _showInAppBanner(String title) {
    final messenger = rootScaffoldMessengerKey.currentState;

    if (messenger == null) return;

    messenger.showSnackBar(
      SnackBar(
        content: Text(title),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
