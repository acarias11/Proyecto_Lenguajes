import 'dart:js_interop';

import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:app_ahorro/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://aycfiajfrsjrkxkmxqgh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF5Y2ZpYWpmcnNqcmt4a214cWdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI0ODU4MTAsImV4cCI6MjAzODA2MTgxMH0.__3i5GG-uXwvAhnrcDrDGEZAf9Lumy-M3Ewhh60YMjs',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
    title: 'App Ahorro',
       initialRoute: 'login',
       routes: {
        'login': (context) => LoginPage(),
        'home':(context) => HomePage(),
        'historial': (context)=> HistorialPage()
       },
        onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error,
                    size: 200,
                  ),
                  Text(
                    'La ruta " ${settings.name} " no existe',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text('Datos'),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        TextFormField(
                          onFieldSubmitted: (value) async {
                            await Supabase.instance.client.from('categorias').insert({'nombre': value});
                          },
                        ),
                        TextFormField(
                          onFieldSubmitted: (value) async {
                            await Supabase.instance.client.from('categorias').insert({'tipo': value});
                          },
                        )
                      ],
                    );
                  },
                  );
              },
              child: const Icon(Icons.add),
              ),
          ),
        );
      },
    );
  }
}
