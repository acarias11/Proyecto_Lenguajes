import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:app_ahorro/inicio_page.dart';
import 'package:app_ahorro/login_page.dart';
import 'package:app_ahorro/registro_page.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro de Cuenta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/signUp': (context) => const RegistroPage(),
        'inicio':(context)=> const InicioPage(),
        'home':(context)=> const MyHomePage(),
        'historial':(context)=> const HistorialPage()
      },
    );
  }
}
 