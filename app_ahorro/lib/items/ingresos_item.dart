import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class IngresosItem extends StatefulWidget {
  @override
  _IngresosItemState createState() => _IngresosItemState();
}

class _IngresosItemState extends State<IngresosItem> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<dynamic> data = [];
   String descripcion = '';
  int monto = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
  try {
   final response = await supabase
          .from('ingresos') // Reemplaza con el nombre de tu tabla
          .select()
          .eq('monto', 'descripcion'); 
          
    if (response.isNotEmpty) {
      setState(() {
        data = response as List<dynamic>; 
      });
    } else {
      throw Exception('Error fetching data:');
    }
  } catch (e) {
    print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['descripcion'].toString()), 
                  subtitle:  Text(data[index]['monto']), 
                );
              },
            ),
    );
  }
}