import 'package:flutter/material.dart';
import 'package:myapp/screens/AddCategoryScreen.dart';
import 'package:myapp/screens/RegisterExpenseScreen.dart';
import 'package:myapp/screens/RegisterIncomeScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/select_currency_screen.dart';
import 'screens/set_cash_balance_screen.dart';
import 'screens/set_account_details_screen.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const AddCategoryScreen(),
        '/RegisterExpenseScreen': (context) => const RegisterExpenseScreen(),
        '/RegisterIncncomeScreen': (context) => const RegisterIncomeScreen(),
        '/select_currency_screen': (context) => const SelectCurrencyScreen(),
        '/set_account_details': (context) =>
            const SetAccountDetailsScreen(), // Cambiamos el orden aquí
        '/set_cash_balance': (context) =>
            const SetCashBalanceScreen(), // Y aquí
      },
    );
  }
}
