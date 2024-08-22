import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/usuario.dart';
import 'package:app_ahorro/widgets/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final contraseniaController = TextEditingController();
  final confirmcontraController = TextEditingController();
  final pinController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final DataController dataController = Get.put(DataController());

  Future<void> registrarUsuario() async {
    try {
      // Validar si el correo ya está registrado
      final List<Usuario> users = await DBHelper.queryUsuarios();
      final bool correoExiste = users.any(
        (usuario) => usuario.email == correoController.text.trim(),
      );

      if (correoExiste) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El correo ya fue registrado')),
        );
        return;
      }

      // Registrar nuevo usuario
      Usuario registrarUsuario = Usuario(
        userId: pinController.text.trim(),
        nombre: nombreController.text.trim(),
        email: correoController.text.trim(),
        contrasena: contraseniaController.text.trim(),
      );

      await dataController.addUsuario(registrarUsuario);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario creado con éxito!')),
      );

      // Redirigir al login después de registrar el usuario
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar usuario: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Crea tu \ncuenta!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: 690,
                width: 600,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18, top: 15),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomInputs(
                          show: false,
                          controller: nombreController,
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'El nombre es obligatorio';
                            }
                            if (valor.length < 3) {
                              return 'El nombre debe tener al menos 3 caracteres';
                            }
                            return null;
                          },
                          teclado: TextInputType.text,
                          nombrelabel: 'Nombre',
                          hint: 'Ingrese su Nombre',
                          icono: Icons.person,
                        ),
                        const SizedBox(height: 20),
                        CustomInputs(
                          show: false,
                          controller: correoController,
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'El correo es obligatorio';
                            }
                            if (!EmailValidator.validate(valor)) {
                              return 'Correo inválido';
                            }
                            return null;
                          },
                          teclado: TextInputType.emailAddress,
                          nombrelabel: 'Correo',
                          hint: 'Ingrese su correo',
                          icono: Icons.email,
                        ),
                        const SizedBox(height: 20),
                        PasswordInput(
                          nombrelabel: 'Contraseña',
                          hint: 'Ingrese su contraseña',
                          controller: contraseniaController,
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            if (valor.length < 8) {
                              return 'La contraseña debe tener al menos 8 caracteres';
                            }
                            if (!valor.contains(RegExp(r'[A-Z]')) ||
                                !valor.contains(RegExp(r'[!@#\$&*~_&-]'))) {
                              return 'La contraseña debe contener una mayúscula y un carácter especial';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        PasswordInput(
                          nombrelabel: 'Confirmar Contraseña',
                          hint: 'Confirma tu Contraseña',
                          controller: confirmcontraController,
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            if (valor != contraseniaController.text) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomInputs(
                          show: true,
                          controller: pinController,
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            if (valor.length != 5) {
                              return 'El pin debe de ser de 5 dígitos';
                            }
                            return null;
                          },
                          teclado: TextInputType.phone,
                          hint: 'Ingrese un pin',
                          nombrelabel: 'Pin',
                          icono: Icons.pin_rounded,
                        ),
                        const SizedBox(height: 70),
                        Container(
                          height: 55,
                          width: 300,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 8, 90, 8),
                              Color.fromARGB(255, 3, 49, 23),
                            ]),
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              if (!formkey.currentState!.validate()) return;
                              registrarUsuario();
                            },
                            child: const Text(
                              'Registrarse',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 150),
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
