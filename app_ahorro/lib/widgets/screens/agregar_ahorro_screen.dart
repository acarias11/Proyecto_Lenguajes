import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';
import 'package:app_ahorro/widgets/custom_inputs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_ahorro/Base De Datos/ahorro.dart';

class AgregarAhorroPage extends StatefulWidget {
  const AgregarAhorroPage({super.key});

  @override
  _AgregarAhorroPageState createState() => _AgregarAhorroPageState();
}

class _AgregarAhorroPageState extends State<AgregarAhorroPage> {
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  List<Cuenta> _cuentas = [];
  Cuenta? _selectedCuenta;

  @override
  void initState() {
    super.initState();
    _loadCuentas();
  }
  
  Future<void> _loadCuentas() async {
    try {
      final cuentas = await DBHelper.queryCuentas();
      setState(() {
        _cuentas = cuentas;
      });
    } catch (e) {
      print('Error al cargar cuentas: $e');
    }
  }

  void _saveGasto() async {
    final monto = double.tryParse(_montoController.text);
    final descripcion = _descripcionController.text;

    if (monto == null || descripcion.isEmpty || _selectedCuenta == null) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Por favor, ingrese un monto, descripción y seleccione una cuenta')),
      );
      return;
    }

    final ahorro = Ahorro(
      monto: monto,
      fecha: DateTime.now(),
      cuentaId: _selectedCuenta!.nombre,
      descripcion: descripcion,
    );

    try {
      await DBHelper.insertAhorro(ahorro);
      Navigator.pop(context);  
    } catch (e) {
      print('Error al agregar el ahorro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al agregar ahorro')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0), 
        child: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent, 
          elevation: 0, 
          flexibleSpace: Container(
            decoration: const BoxDecoration(
               gradient: LinearGradient(colors: [
                Color.fromARGB(255, 8, 90, 8),
                Color.fromARGB(255, 3, 49, 23),
              ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children:[ 
                Container(
                    height: 900,
              width: 600,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 8, 90, 8),
                Color.fromARGB(255, 3, 49, 23),
              ])),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Agrega tus \nahorros!',
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
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: 690,
                width: 600,

                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  CustomInputs(
                    show: false,
                    controller: _montoController,
                    teclado: TextInputType.number,
                    validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'El monto es obligatorio';
                            }

                            if (double.tryParse(_montoController.text)!<1) {
                              return 'Los valosres no pueden ser menores que 1';
                            }

                            return null;
                          },
                    nombrelabel:  'Monto',
                    hint: 'Ingrese el monto',
                    icono: Icons.money_rounded,
                  ),
                  CustomInputs(
                    show: false,
                    controller: _descripcionController,
                    validator: null,
                    nombrelabel: 'Descripción',
                    teclado: TextInputType.text,
                    hint: 'Ingrese una descripcion del ahorro',
                    icono: FontAwesomeIcons.pen,
                  ),
                  DropdownButton<Cuenta>(
                    hint: const Text('Selecciona una cuenta'),
                    value: _selectedCuenta,
                    onChanged: (Cuenta? newValue) {
                      setState(() {
                        _selectedCuenta = newValue;
                      });
                    },
                    items: _cuentas.map<DropdownMenuItem<Cuenta>>((Cuenta cuenta) {
                      return DropdownMenuItem<Cuenta>(
                        value: cuenta,
                        child: Text(cuenta.nombre),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 70),
                      Container(
                        height: 55,
                        width: 300,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 8, 90, 8),
                              Color.fromARGB(255, 3, 49, 23),
                            ])),
                        child: OutlinedButton(
                          onPressed: () {
                            _saveGasto();
                          },
                          child: const Text(
                            'Guardar Gasto',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
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
