import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          child: const Padding(
            padding:  EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}