import 'package:flutter/material.dart';
import 'package:app_ahorro/widgets/custom_inputs.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  
  final correocontroller = TextEditingController();
  final contracontroller = TextEditingController();
  final GlobalKey<FormState> fkey = GlobalKey<FormState>();

    


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.06), //disminuye el tamanio del appbar 
          child: AppBar(
          ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            //Todavia no se me ocurren los colores
          ),
          child: Padding(
            padding:  const EdgeInsets.all(18),
            child: Column(
              children: [
               const  Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             SizedBox(height: 130),
                          Image(
                             image: AssetImage('assets/images/gif_para_login.gif'),
                             height: 300,
                             width: 200,
                             fit: BoxFit.fill,
                           )
                   ],
                   
                ),
                CustomInputs(
                    nombrelabel: 'Correo',
                    hint: 'Ingrese su correo',
                    teclado: TextInputType.emailAddress,
                    controller: correocontroller, 
                    icono: Icons.email,
                    validator: null
                   ),
                  
                  const SizedBox(height: 20,),
        
                   PasswordInput(
                    nombrelabel: 'Password',
                    hint: 'Ingrese su contrasenia',
                    controller: contracontroller, 
                    validator: null, 
                    ),
                    const SizedBox(height: 20,),
                     Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 100),
                            SizedBox(
                              height: 60,
                              width: 300,
                              child: ElevatedButton(
                                onPressed:(){
                                  Navigator.of(context).popAndPushNamed('home',arguments: {
                                    'correo': correocontroller.text,
                                    'contraseña': contracontroller.text,
                                  }); 
                                              
                              }, 
                              child:
                                 const Text('Ingresar',
                                     style: TextStyle(
                                     fontSize: 25,
                                     fontWeight: FontWeight.bold,
                                     fontStyle: FontStyle.italic,
                                     color: Colors.black),
                                     ),
                              ),
                            ),
                   ],
                 ),  
                  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 100),
                            SizedBox(
                              height: 60,
                              width: 300,
                              child: ElevatedButton(
                                onPressed:(){
                                 Navigator.of(context).pushNamed('registro');                                                 
          
                              }, 
                              child:
                                 const Text('Registrarse',
                                     style: TextStyle(
                                     fontSize: 25,
                                     fontWeight: FontWeight.bold,
                                     fontStyle: FontStyle.italic,
                                     color: Colors.black),
                                     ),
                              ),
                            ),
                   ],
                 ),  
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}