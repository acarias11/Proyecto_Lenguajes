import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/usuario.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:get/get.dart'; // Importar DBHelper

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final userID = ModalRoute.of(context)!.settings.arguments;
    Future<void> _validateUser(BuildContext context) async {
      // Inicializar la base de datos (opcional si ya lo has hecho en otro lugar)
      await DBHelper.initDB();

      // Obtener el userId almacenado (suponiendo que lo tienes en SharedPreferences)
      String? userId = await DBHelper.getUserIdFromSharedPreferences();

      if (userId == null) {
        // El usuario no tiene un userId almacenado, navegar a la pantalla de login
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // El usuario tiene un userId almacenado, buscar en la base de datos
        final List<Usuario> users = await DBHelper.queryUsuarios();
        final Usuario? user = users
            .firstWhereOrNull((u) => u.userId.toString() == userId.toString());
        final List<Cuenta> cuentas = await DBHelper.queryCuentas();
        final Cuenta? cuenta = cuentas.firstWhereOrNull(
            (c) => user?.userId.toString() == c.userid.toString());

        if (cuenta.toString() == null) {
          // El usuario existe en la base de datos pero no tiene una cuenta completa
          Navigator.pushReplacementNamed(context, '/select_account_details',
              arguments: userID);
        } else {
          if (user?.userId.toString() == cuenta?.userid.toString()) {
            Navigator.pushReplacementNamed(context, '/inicio', arguments: user);
          }
          // El usuario existe y tiene una cuenta completa, navegar a la pantalla de inicio
        }
      }
    }

    @override
    void initState() {
      super.initState();
      _validateUser(context);
    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
