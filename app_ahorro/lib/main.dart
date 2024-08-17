import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:app_ahorro/inicio_page.dart';
import 'package:app_ahorro/items/ingresos_item.dart';
import 'package:app_ahorro/login_page.dart';
import 'package:app_ahorro/registro_page.dart';
import 'package:app_ahorro/widgets/screens/AddCategoryScreen.dart';
import 'package:app_ahorro/widgets/screens/RegisterExpenseScreen.dart';
import 'package:app_ahorro/widgets/screens/RegisterIncomeScreen.dart';
import 'package:app_ahorro/widgets/screens/select_currency_screen.dart';
import 'package:app_ahorro/widgets/screens/set_account_details_screen.dart';
import 'package:app_ahorro/widgets/screens/set_cash_balance_screen.dart';
import 'package:app_ahorro/widgets/screens/welcome_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://aycfiajfrsjrkxkmxqgh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF5Y2ZpYWpmcnNqcmt4a214cWdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI0ODU4MTAsImV4cCI6MjAzODA2MTgxMH0.__3i5GG-uXwvAhnrcDrDGEZAf9Lumy-M3Ewhh60YMjs',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Cuenta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'inicio',
      routes: {
        '/': (context) => const LoginPage(),
        '/SignUp': (context) => RegistroPage(),
        '/RegisterExpenseScreen': (context) => const RegisterExpenseScreen(),
        '/RegisterIncncomeScreen': (context) => const RegisterIncomeScreen(),
        '/select_currency_screen': (context) => const SelectCurrencyScreen(),
        '/set_account_details': (context) =>
            const SetAccountDetailsScreen(), // Cambiamos el orden aquí
        '/set_cash_balance': (context) =>
            const SetCashBalanceScreen(), // Y aquí
        'inicio':(context)=>LoginPage(),
        'home':(context)=>MyHomePage(),
        'historial':(context)=>HistorialPage()
      },
    );
  }
}
 