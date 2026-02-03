import 'package:flutter/material.dart';

class DetallesPage extends StatelessWidget {
  const DetallesPage({super.key});

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
