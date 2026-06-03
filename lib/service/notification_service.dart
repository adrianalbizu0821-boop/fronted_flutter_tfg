import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../main.dart'; // para acceder al scaffoldMessengerKey

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Para hacer loggins si se desea
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initFCM() async {
    // Registrar handler background
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Solicitar permisos (Android 13+ e iOS)
    await _messaging.requestPermission(
      alert: true, badge: true, sound: true, provisional: false,
    );

    // Obtener token
    final token = await _messaging.getToken();
    debugPrint('FCM TOKEN: $token');

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      final title = msg.notification?.title ?? 'Nueva notificación';
      _showInAppBanner(title);
    });

    // Abierta desde notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      // TODO: si recibes data con ruta/ID, navega aquí
    });

    // Cambio de token
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      debugPrint('FCM TOKEN REFRESH: $newToken');
      // TODO: enviar al backend cuando esté listo
    });
  }

  static void _showInAppBanner(String title) {
    final messenger = rootScaffoldMessengerKey.currentState;
    messenger?.showSnackBar(
      SnackBar(
        content: Text(title),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
