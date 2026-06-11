import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            const Icon(
              Icons.newspaper,
              size: 80,
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                'TFG Noticias',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),
            ),

            const SizedBox(height: 30),

            const ListTile(
              leading: Icon(Icons.info),
              title: Text('Versión'),
              subtitle: Text('1.0.0'),
            ),

            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Autor'),
              subtitle: Text('Adrián Albizu'),
            ),

            const ListTile(
              leading: Icon(Icons.school),
              title: Text('Proyecto'),
              subtitle: Text('Trabajo Fin de Grado - DAM'),
            ),

            const Divider(),

            const ListTile(
              leading: Icon(Icons.code),
              title: Text('Tecnologías utilizadas'),
              subtitle: Text(
                'Flutter\n'
                'Spring Boot\n'
                'Firebase Cloud Messaging\n'
                'MySQL\n'
                'WordPress REST API',
              ),
            ),

            const Divider(),

            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Aplicación desarrollada para consultar noticias del centro educativo y recibir notificaciones push en tiempo real.',
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}