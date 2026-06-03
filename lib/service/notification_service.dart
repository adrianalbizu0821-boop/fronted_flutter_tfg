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
  static bool _initialized = false;

  static Future<void> initFCM() async {
    if (_initialized) return;
    _initialized = true;
    // Registrar handler background
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Solicitar permisos (Android 13+ e iOS)
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    // Obtener token
    final token = await _messaging.getToken();
    debugPrint('FCM TOKEN: $token');

    //Cuando se abre desde una notificacion y la app esta cerrada
    final initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {
      debugPrint('App abierta desde notificación: ${initialMessage.messageId}');
    }

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
