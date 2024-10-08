import 'package:flutter/material.dart';

class WelcomeScreenPage extends StatelessWidget {
  const WelcomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
       child: Container(
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
         child: Column(
           children: [
             const Padding(
               padding: EdgeInsets.only(top: 200.0),
               child: Image(image: AssetImage('assets/images/gif_para_loogin.gif'),
                              height: 200,
                               width:150,
                               fit: BoxFit.fill,),
                               
             ),
             const Text('CashBack',style: TextStyle(
               fontSize: 30,
               color: Colors.white
             ),),
             const SizedBox(
               height: 100,
             ),
             const Text('Welcome Back',style: TextStyle(
               fontSize: 30,
               color: Colors.white
             ),),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/login');
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(child: Text('SIGN IN',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),),),
              ),
            ),
             const SizedBox(height: 30,),
             GestureDetector(
               onTap: (){
                 Navigator.of(context).pushNamed('/signUp');
               },
               child: Container(
                 height: 53,
                 width: 320,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(30),
                   border: Border.all(color: Colors.white),
                 ),
                 child: const Center(child: Text('SIGN UP',style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                     color: Colors.black
                 ),),),
               ),
             ),
           ]
         ),
       ),
     ),

    );
  }
}