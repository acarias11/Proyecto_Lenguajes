import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('App Ahorro'),
        ),
        
    );
  }
}

Color getCategoryColor(String category) {
  switch (category) {
    case 'Gastos':
      return Colors.red[400]!;
    case 'Ingresos':
      return Colors.green[400]!;
    case 'Ahorros':
      return Colors.blue[400]!;
    default:
      return Colors.orange[400]!;
  }
}
        
