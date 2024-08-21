import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:app_ahorro/inicio_page.dart';
import 'package:app_ahorro/login_page.dart';
import 'package:app_ahorro/registro_page.dart';
import 'package:app_ahorro/widgets/screens/select_currency_screen.dart';
import 'package:app_ahorro/widgets/screens/set_account_details_screen.dart';
import 'package:app_ahorro/widgets/screens/welcome_screen_page.dart';
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
        '/': (context) => const WelcomeScreenPage(),
        '/login':(context)=>const LoginPage(),
        '/signUp': (context) => const RegistroPage(),
        '/select_currency_screen': (context) => const SelectCurrencyScreen(),
        '/select_account_details': (context) => SetAccountDetailsScreen(),
        '/inicio':(context)=>InicioPage(),
        'home': (context) => const HomePage(),
        'historial': (context) => const HistorialPage()
      },
    );
  }
}