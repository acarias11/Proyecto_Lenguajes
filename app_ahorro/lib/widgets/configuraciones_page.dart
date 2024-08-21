import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _goalController = TextEditingController();
  double _goal = 1000.0;

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _goal = prefs.getDouble('goal') ?? _goal;
      _goalController.text = _goal.toString();
    });
  }

  Future<void> _saveGoal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _goal = double.tryParse(_goalController.text) ?? _goal;
      prefs.setDouble('goal', _goal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Cambiar Meta de Ahorro
          ListTile(
            title: const Text('Meta de Ahorro'),
            leading: const Icon(Icons.assessment),
            subtitle: TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese nueva meta',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _saveGoal,
            child: const Text('Guardar Meta'),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Cambiar Moneda'),
            leading: const Icon(Icons.monetization_on),
            onTap: () {
              // Navegar a cambiar moneda
            },
          ),
          ListTile(
            title: const Text('Cambiar tipo de cuenta'),
            leading: const Icon(Icons.category),
            onTap: () {
              // Navegar a cambiar tipo de cuenta
            },
          ),
          ListTile(
            title: const Text('Borrar ingreso'),
            leading: const Icon(Icons.remove_circle_outline),
            onTap: () {
              // Navegar a borrar ingreso
            },
          ),
          ListTile(
            title: const Text('Borrar Gasto'),
            leading: const Icon(Icons.remove_circle),
            onTap: () {
              // Navegar a borrar gasto
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out')),
              );
              Navigator.of(context).pop('/login');
            },
            child: const Text('Log Out', style: TextStyle(fontSize: 20, color: Colors.black),),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
