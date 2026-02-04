import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de noticia'),
      ),
      body: const Center(
        child: Text('Detalle de la noticia'),
      ),
    );
  }
}
