import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _confirmarContrasenaController = TextEditingController();

  Future<void> _registrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      // Los datos son válidos, procedemos a guardar en la base de datos
      String nombre = _nombreController.text;
      String email = _emailController.text;
      String contrasena = _contrasenaController.text;

      // Abrir la base de datos y ejecutar la inserción
      final db = await openDatabase(
        join(await getDatabasesPath(), 'app_ahorro.db'),
      );

      await db.insert(
        'usuario',
        {'nombre': nombre, 'email': email, 'contrasena': contrasena}
      );

      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(BuildContext as BuildContext).showSnackBar(
        const SnackBar(content: Text('Usuario registrado exitosamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Usuario')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+(.[a-zA-Z]+)?$").hasMatch(value!)) {
                    return 'Ingrese un correo electrónico válido';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
              ),
              TextFormField(
                controller: _contrasenaController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$').hasMatch(value)) {
                    return 'La contraseña debe contener al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Contraseña'),
              ),
              TextFormField(
                controller: _confirmarContrasenaController,
                obscureText: true,
                validator: (value) {
                  if (value != _contrasenaController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Confirmar contraseña'),
              ),
              ElevatedButton(
                onPressed: _registrarUsuario,
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}