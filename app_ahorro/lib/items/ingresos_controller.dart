import 'package:flutter/material.dart';

class IngresosItem extends StatelessWidget {
  const IngresosItem({super.key, required this.ingresos});

  final Map<String, dynamic> ingresos;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.green[ingresos['monto'].truncate()],
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${ingresos['nombre']}',
              style: const TextStyle(fontSize: 30),
            ),
            Text('${ingresos['calorias']} calorias',
                style: const TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}