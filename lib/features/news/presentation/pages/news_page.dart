import 'package:flutter/material.dart';
import 'package:fronted_flutter_tfg/features/settings/settings_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context,index){
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 50),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Titulo ${index + 1}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Descripcion corta de la noticia',
                  ),
                ],
              )
              ),
          );
        }
        ),
    );
  }
}
