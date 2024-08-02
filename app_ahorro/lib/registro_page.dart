import 'package:app_ahorro/widgets/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistroPage extends StatelessWidget {
  RegistroPage({super.key});

  final supabase = Supabase.instance.client;
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final contraseniaController = TextEditingController();
  final confirmcontraController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final List<String> dominios = ['gmail.com', 'yahoo.com', 'outlook.com', 'hotmail.com'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    CustomInputs(
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
                      icono: Icons.person
                      ),
                      const SizedBox(height: 20,),
                      CustomInputs(
                        controller: correoController, 
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                          return 'El correo es obligatorio';
                        }
            
                        if (valor.contains('@') == false) {
                          return 'El correo no es valido, debe contener un @';
                        }

                        if ((valor.length == valor.replaceAll('@', '').length + 1) == false) {
                          return 'El correo solo debe tener un arroba';
                        }

                        if ((valor.contains('@') && dominios.any((dominio) => valor.contains(dominio)) && valor.substring(valor.indexOf('@')+1, valor.indexOf('.com')).isNotEmpty) == false) {
                          return 'El correo es invalido';
                        }
            
                        if(dominios.any((dominio) => valor.endsWith('.com')) == false){
                          return 'El correo no es valido';
                        }
            
                        return null;
                        }, 
                        teclado: TextInputType.emailAddress,   
                        nombrelabel: 'Correo',
                        hint: 'Ingrese su correo', 
                        icono: Icons.email
                      ),
                      const SizedBox(height: 20,),
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
            
                        if (valor.contains(RegExp(r'[A-Z]')) == false && valor.contains(RegExp(r'^(?=.*?[!@#\$&*~_&-])')) == false) {
                          return 'La contraseña debe contener una mayuscula y un caracter especial';
                        }
            
                        return null;
                      },
                      ),
                      const SizedBox(height: 20,),
                      PasswordInput(
                        nombrelabel: 'Confirmar Contraseña', 
                        hint: 'Confrima tu Contraseña', 
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
                  ],
                ),
                ),
              ),
              const SizedBox(height: 30,),
          SizedBox(
            height: 60,
            width: 300,
            child: ElevatedButton(
            child: const Text('Registrar',
                                     style: TextStyle(
                                     fontSize: 25,
                                     fontWeight: FontWeight.bold,
                                     fontStyle: FontStyle.italic,
                                     color: Colors.black),),
          onPressed: () async {
            final nombre = nombreController.text.trim();
            final email = correoController.text.trim();
            final password = contraseniaController.text.trim();
              if (!formkey.currentState!.validate()) return;
              await supabase.from('usuarios').insert({
                'nombre': nombre,
                'email': email,
                'password': password
              });
          },

            ),
          ),
          ],
        ),
      ),
        
    );
  }
}