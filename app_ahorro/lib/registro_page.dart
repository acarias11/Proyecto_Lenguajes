import 'package:app_ahorro/widgets/custom_inputs.dart';
import 'package:app_ahorro/widgets/screens/select_currency_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistroPage extends StatefulWidget {
  RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final supabase = Supabase.instance.client;

  final nombreController = TextEditingController();

  final correoController = TextEditingController();

  final contraseniaController = TextEditingController();

  final confirmcontraController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> signUP() async {
    try {
      await supabase.auth.signUp(
        email: correoController.text.trim(),
        password: contraseniaController.text.trim(),
        data: {'user': nombreController.text.trim()}
        );
        if(!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SelectCurrencyScreen()));
    } on AuthException catch(e) {
      ScaffoldMessenger(child: Text(e.message));
    }
    final data = supabase.auth.currentUser!.userMetadata;
    final userid = supabase.auth.currentUser!.id;
    await supabase.from('usuarios').insert({'id_user': userid, 'nombre': data?['user'], 'email': data?['email']});
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
             gradient: LinearGradient(
               colors: [
                 Color.fromARGB(255, 8, 90, 8),
                 Color.fromARGB(255, 3, 49, 23),
               ]
             )
                   ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Crea tu \ncuenta!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: 690,
                width: 600,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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



                     
                      const SizedBox(height: 70,),
                       Container(
                      height: 55,
                      width: 300,
                       decoration: const BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(40)),
           gradient: LinearGradient(
             colors: [
               Color.fromARGB(255, 8, 90, 8),
               Color.fromARGB(255, 3, 49, 23),
             ]
           )
                 ),
                      child: OutlinedButton(
                                  onPressed:(){
                                    signUP();          
                                }, 
                                child:
                                   const Text('Registrarse',
                                       style: TextStyle(
                                       fontSize: 25,
                                       fontWeight: FontWeight.bold,
                                       fontStyle: FontStyle.italic,
                                       color: Colors.white),
                                       ),
                                ),
                              ),
          
                      const SizedBox(height: 150,),
                  ],
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