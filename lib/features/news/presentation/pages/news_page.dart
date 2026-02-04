import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Noticias'),
      ),
      body: const Center(
        child: Text(
          'Aquí se mostrará el feed de noticias',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white
            ),
        ),
      ),
    );
  }
}
