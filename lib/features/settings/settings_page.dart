import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool activarNotis=true;
  bool ultimasNoticias= true;
  bool resumenDiario=false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.all(16),
          child: Text(
            'Notificaciones',
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          ),
          ),
         SwitchListTile(
            title: const Text('Activar notificaciones'),
            value: activarNotis,
            onChanged: (value) {
              setState(() {
                activarNotis = value;
              });
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
           SwitchListTile(
            title: const Text('Resumen diario'),
            value: resumenDiario,
            onChanged: activarNotis
                ? (value) {
                    setState(() {
                      resumenDiario = value;
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }

  

}


