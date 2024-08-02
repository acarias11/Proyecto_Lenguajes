
import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:app_ahorro/login_page.dart';
import 'package:app_ahorro/registro_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://aycfiajfrsjrkxkmxqgh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF5Y2ZpYWpmcnNqcmt4a214cWdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI0ODU4MTAsImV4cCI6MjAzODA2MTgxMH0.__3i5GG-uXwvAhnrcDrDGEZAf9Lumy-M3Ewhh60YMjs',
  );
  runApp(const  MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
       title: 'App ahorro',
       initialRoute: 'login',
       routes: {
        'login': (context) => LoginPage(),
        'home':(context) =>const  MyHomePage(),
        'registro': (context)=> RegistroPage(),
        'historial':(context)=> const HistorialPage()
       },
    );
  }
}

