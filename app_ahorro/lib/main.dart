import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/usuario.dart';
import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:app_ahorro/inicio_page.dart';
import 'package:app_ahorro/login_page.dart';
import 'package:app_ahorro/registro_page.dart';
import 'package:app_ahorro/widgets/primer_ingreso_screen.dart';
import 'package:app_ahorro/widgets/screens/set_account_details_screen.dart';
import 'package:app_ahorro/widgets/screens/welcome_screen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    return userId != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro de Cuenta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras esperas
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Maneja el error en caso de fallo
            return const Center(child: Text('Error al verificar el estado de la sesión'));
          } else {
            if (snapshot.data == true) {
              // Redirige a la pantalla principal si el usuario está logueado
              return const InicioPage();
            } else {
              // Redirige a la pantalla de login si el usuario no está logueado
              return const WelcomeScreenPage();
            }
          }
        },
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const RegistroPage(),
        '/select_account_details': (context) => const SetAccountDetailsScreen(usuario: Usuario),
        '/inicio': (context) => const InicioPage(),
        'home': (context) => const HomePage(),
        'historial': (context) => const HistorialPage(),
        '/monto': (context) => const PrimerIngresoScreen(),
      },
    );
  }
}

