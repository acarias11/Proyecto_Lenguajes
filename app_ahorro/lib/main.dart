import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:app_ahorro/inicio_page.dart';
import 'package:app_ahorro/login_page.dart';
import 'package:app_ahorro/registro_page.dart';
import 'package:app_ahorro/widgets/screens/select_currency_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  runApp(const MyApp());
}

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
        '/inicio': (context) => const InicioPage(),
        '/select_currency_screen': (context) => const SelectCurrencyScreen(),
        '/home': (context) => const MyHomePage(),
        '/historial': (context) => const HistorialPage()
      },
    );
  }
}
