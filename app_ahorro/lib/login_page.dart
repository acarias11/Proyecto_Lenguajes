import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';
import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/usuario.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/widgets/custom_inputs.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DataController dataController = Get.put(DataController());
  final pinController = TextEditingController();
  final correocontroller = TextEditingController();
  final contracontroller = TextEditingController();
  final GlobalKey<FormState> fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 900,
              width: 600,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 8, 90, 8),
                Color.fromARGB(255, 3, 49, 23),
              ])),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Bienvenido \ningresa!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Form(
                key: fkey,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                  ),
                  height: 690,
                  width: 600,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomInputs(
                          show: false,
                          nombrelabel: 'Correo',
                          hint: 'Ingrese su correo',
                          teclado: TextInputType.emailAddress,
                          controller: correocontroller,
                          icono: Icons.check,
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'El correo es obligatorio';
                            }

                            try {
                              dataController.usuarioList.firstWhere(
                                (usuario) => usuario.email == valor,
                              );
                            } catch (e) {
                              return 'Correo invalido';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        PasswordInput(
                          nombrelabel: 'Password',
                          hint: 'Ingrese su contraseña',
                          controller: contracontroller,
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'La contraseña es obligatoria';
                            }

                            try {
                              dataController.usuarioList
                                  .firstWhere(
                                    (usuario) => usuario.contrasena == valor,
                                  )
                                  .toString();
                            } catch (e) {
                              return 'Contraseña inválida';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomInputs(
                            show: true,
                            controller: pinController,
                            validator: (valor) {
                              if (valor == null || valor.isEmpty) {
                                return 'Este campo es obligatorio';
                              }

                              if (valor.length != 5) {
                                return 'El pin debe de ser de 5 digitos';
                              }

                              try {
                                dataController.usuarioList
                                    .firstWhere(
                                      (usuario) => usuario.userId == valor,
                                    )
                                    .toString();
                              } catch (e) {
                                return 'Pin inválido';
                              }

                              return null;
                            },
                            teclado: TextInputType.phone,
                            hint: 'Ingrese su pin',
                            nombrelabel: 'Pin',
                            icono: Icons.pin_rounded),
                        const SizedBox(
                          height: 70,
                        ),
                        Container(
                          height: 55,
                          width: 300,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 8, 90, 8),
                                Color.fromARGB(255, 3, 49, 23),
                              ])),
                          child: OutlinedButton(
                            onPressed: () async {
                              if (!fkey.currentState!.validate()) return;
                              String? userId = await DBHelper
                                  .getUserIdFromSharedPreferences();
                              final List<Usuario> users =
                                  await DBHelper.queryUsuarios();
                              final Usuario? user = users.firstWhereOrNull(
                                  (u) =>
                                      u.userId.toString() == userId.toString());
                              final List<Cuenta> cuentas =
                                  await DBHelper.queryCuentas();
                              final Cuenta? cuenta = cuentas.firstWhereOrNull(
                                  (c) =>
                                      user?.userId.toString() ==
                                      c.userid.toString());
                              if (cuenta?.userid == null && user?.userId == null) {
                                // El usuario existe en la base de datos pero no tiene una cuenta completa
                                if (cuenta?.cuentaCompleta == false) {
                                  Navigator.pushReplacementNamed(
                                    context, '/select_account_details',
                                    arguments: pinController.text.toString());
                                }else{
                                  Navigator.pushReplacementNamed(
                                  context,
                                  '/inicio',
                                );
                                }
                              } 
                            },
                            child: const Text(
                              'Ingresar',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "No tienes una cuenta?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/signUp');
                                },
                                child: const Text(
                                  "Registrate",
                                  style: TextStyle(

                                      ///done login page
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
