import 'package:flutter/material.dart';
import '/service/preferences_service.dart';
import '/service/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '/service/backend_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool activarNotis = false;
  bool ultimasNoticias = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    activarNotis = await PreferencesService.areNotificationsEnabled();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Notificaciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text('Activar notificaciones'),
            subtitle: const Text(
              'Permite recibir notificaciones push de noticias y actualizaciones',
            ),
            value: activarNotis,
            onChanged: (value) async {
              await PreferencesService.setNotificationsEnabled(value);

              setState(() {
                activarNotis = value;
              });

              if (value) {
                await NotificationService.initFCM();

                final token = await FirebaseMessaging.instance.getToken();

                debugPrint('TOKEN PARA BACKEND: $token');

                if (token != null) {
                  await BackendService.registerToken(token);

                  debugPrint('Token registrado correctamente en backend');
                }
              } else {
                final token = await FirebaseMessaging.instance.getToken();

                debugPrint('TOKEN A ELIMINAR: $token');

                if (token != null) {
                  await BackendService.deleteToken(token);
                }

                await FirebaseMessaging.instance.deleteToken();

                debugPrint('Notificaciones desactivadas');
              }
            },
          ),
          SwitchListTile(
            title: const Text('Últimas noticias'),
            value: ultimasNoticias,
            onChanged: activarNotis
                ? (value) {
                    setState(() {
                      ultimasNoticias = value;
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
