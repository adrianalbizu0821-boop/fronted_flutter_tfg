import 'package:flutter/material.dart';
import '../../features/news/presentation/pages/news_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> const NewsPage()));
          } ,

          child: const Text('Ir a noticias')),
      ),
    );
  }
  
}