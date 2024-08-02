import 'package:app_ahorro/widgets/custom_inputs.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  RegistroPage({super.key});

  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final telefonoController = TextEditingController();
  final contraseniaController = TextEditingController();
  final confirmcontraController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
            
                        if (valor.length > 10) {
                          return 'El nombre debe tener maximo 10 caracteres';
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

                        if ((valor.contains('@') && valor.contains('.edu.hn') && valor.substring(valor.indexOf('@')+1, valor.indexOf('.edu.hn')).isNotEmpty) == false) {
                          return 'El correo debe tener un dominio';
                        }
            
                        if(valor.endsWith('.edu.hn') == false){
                          return 'El correo no es valido, debe terminar en ".edu.hn"';
                        }
            
                        return null;
                        }, 
                        teclado: TextInputType.emailAddress,   
                        nombrelabel: 'Correo',
                        hint: 'Ingrese su correo', 
                        icono: Icons.email
                      ),
                      const SizedBox(height: 20,),
                      CustomInputs(
                        controller: telefonoController, 
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                          return 'El telefono es obligatorio';
                        }
            
                        if (valor.length < 8 || valor.length > 8) {
                          return 'El telefono debe de ser de 8 numeros';
                        }

                        if (valor.startsWith('3') == false && valor.startsWith('9') == false) {
                          return 'El numero es invalido, debe iniciar con 3 o 9';
                        }
            
                        return null;
                        }, 
                        teclado: TextInputType.phone, 
                        nombrelabel: 'Telefono',
                        hint: 'Ingrese su telefono', 
                        icono: Icons.phone
                      ),
                      const SizedBox(height: 20,),
                      PasswordInput(
                        nombrelabel: 'Contraseña',
                        hint: 'Ingrese su contraseña', 
                        controller: contraseniaController,
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                          return 'El nombre es obligatorio';
                        }
            
                        if (valor.length < 8) {
                          return 'La contraseña debe tener al menos 8 caracteres';
                        }
            
                        if (valor.contains(RegExp(r'[A-Z]')) == false) {
                          return 'La contraseña es invalida, debe al menos tener una mayuscula';
                        }
            
                        if (valor.contains(RegExp(r'^(?=.*?[!@#\$&*~_&-])')) == false) {
                          return 'La contraseña debe contener un caracter especial';
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
            onPressed: () {
              if(!formkey.currentState!.validate()) return;
              final datos = {
                'nombre': nombreController.text,
                'correo': correoController.text,
                'telefono': telefonoController.text,
                'contraseña': contraseniaController.text,
                'confirmarContraseña': confirmcontraController.text
              };
            
              print(datos);  
            
            },
            ),
          ),
          ],
        ),
      ),
        
    );
  }
}