import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'service/notification_service.dart';
import 'service/preferences_service.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>();    

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final notificationsEnabled =
      await PreferencesService.areNotificationsEnabled();

  if (notificationsEnabled) {//Si el usuario acepta notis, envia el tocken
    await NotificationService.initFCM();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
