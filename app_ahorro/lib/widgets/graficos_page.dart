import 'package:app_ahorro/widgets/grafico_circular.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/widgets/graph.dart';
import 'package:app_ahorro/widgets/grafico_gastos.dart';

class UnidosGraficosPage extends StatefulWidget {
   const UnidosGraficosPage({super.key});


  @override
  State<UnidosGraficosPage> createState() => _UnidosGraficosPageState();
}

class _UnidosGraficosPageState extends State<UnidosGraficosPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: [
              SizedBox(height: 50.0),
           SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:  Column(
                  children: [
                     SizedBox(
                      height: 250,
                      width: 400,
                      child:PieChartSample2()
                    ),
                     SizedBox(
                      height: 200,
                      width: 350,                      
                      child: LineChartWidget(
                        gradientColor1: Color.fromARGB(255, 26, 171, 13),
                        gradientColor2: Color.fromARGB(255, 105, 168, 110),
                        gradientColor3: Color.fromARGB(255, 57, 103, 52),
                        indicatorStrokeColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                     SizedBox(
                      height: 200,
                      width: 300,  
                     child: LineChartGastosWidget(gradientColor1: Color.fromARGB(255, 212, 5, 5),
                        gradientColor2: Color.fromARGB(255, 218, 107, 79),
                        gradientColor3: Color.fromARGB(255, 240, 143, 16),
                        indicatorStrokeColor: Color.fromARGB(255, 0, 0, 0),)
                     ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}