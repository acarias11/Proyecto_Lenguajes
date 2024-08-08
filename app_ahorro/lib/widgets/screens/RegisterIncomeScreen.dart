import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterIncomeScreen extends StatefulWidget {
  const RegisterIncomeScreen({super.key});

  @override
  _RegisterIncomeScreenState createState() => _RegisterIncomeScreenState();
}

class _RegisterIncomeScreenState extends State<RegisterIncomeScreen> {
  String _cuenta = '';
  List<Map<String, dynamic>> _cuentas = [];

  String _categoria = '';
  List<Map<String, dynamic>> _categorias = [];

  final supabase = Supabase.instance.client;

  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchCuentas();
    _fetchCategorias();
  }

  Future<void> _fetchCuentas() async {
    final response = await supabase.from('cuentas').select('id, nombre');
    print('Response cuentas: $response');

    setState(() {
      _cuentas = List<Map<String, dynamic>>.from(response.map((cuenta) => {
            'id': cuenta['id'],
            'nombre': cuenta['nombre'],
          }));
      _cuenta = _cuentas.isNotEmpty ? _cuentas[0]['id'].toString() : '';
    });
  }

  Future<void> _fetchCategorias() async {
    try {
      final response = await supabase
          .from('categorias')
          .select('id, nombre')
          .eq('tipo', 'ingresos');
      print('Response categorias: $response');

      setState(() {
        _categorias =
            List<Map<String, dynamic>>.from(response.map((categoria) => {
                  'id': categoria['id'],
                  'nombre': categoria['nombre'],
                }));
        _categoria =
            _categorias.isNotEmpty ? _categorias[0]['id'].toString() : '';
      });
    } catch (error) {
      print('Error fetching categorias: $error');
    }
  }

  Future<void> _registerIncome() async {
    final monto = double.tryParse(_montoController.text);
    final descripcion = _descripcionController.text;

    if (monto == null || descripcion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor ingrese todos los campos correctamente')),
      );
      return;
    }

    try {
      final response = await supabase.from('ingresos').insert({
        'monto': monto,
        'fecha': DateTime.now().toIso8601String(),
        'categoria_id': int.parse(_categoria),
        'cuenta_id': int.parse(_cuenta),
        'descripcion': descripcion,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingreso registrado exitosamente')),
      );

      // Limpiar los campos después de registrar
      _montoController.clear();
      _descripcionController.clear();
      setState(() {
        _cuenta = _cuentas.isNotEmpty ? _cuentas[0]['id'].toString() : '';
        _categoria =
            _categorias.isNotEmpty ? _categorias[0]['id'].toString() : '';
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Ingreso'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Seleccionar Cuenta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _cuentas.isEmpty
                  ? const CircularProgressIndicator()
                  : DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Cuenta',
                        labelStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      value: _cuenta,
                      onChanged: (newValue) {
                        setState(() {
                          _cuenta = newValue!;
                        });
                      },
                      items: _cuentas.map<DropdownMenuItem<String>>((cuenta) {
                        return DropdownMenuItem<String>(
                          value: cuenta['id'].toString(),
                          child: Text(cuenta['nombre'],
                              style: const TextStyle(fontSize: 16)),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 20),
              const Text(
                'Seleccionar Categoría',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _categorias.isEmpty
                  ? const CircularProgressIndicator()
                  : DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Categoría',
                        labelStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      value: _categoria,
                      onChanged: (newValue) {
                        setState(() {
                          _categoria = newValue!;
                        });
                      },
                      items: _categorias
                          .map<DropdownMenuItem<String>>((categoria) {
                        return DropdownMenuItem<String>(
                          value: categoria['id'].toString(),
                          child: Text(categoria['nombre'],
                              style: const TextStyle(fontSize: 16)),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 20),
              const Text(
                'Ingresar Monto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _montoController,
                decoration: InputDecoration(
                  labelText: 'Monto',
                  labelStyle: const TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  if (double.tryParse(value)! <= 0) {
                    return 'Por favor ingrese un monto positivo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Ingresar Descripción',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: const TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registerIncome();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
