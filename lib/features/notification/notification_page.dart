import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: const Center(
        child: Text(
          'Pantalla de Ajustes',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
