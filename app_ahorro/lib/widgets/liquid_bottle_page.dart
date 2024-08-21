import 'package:flutter/material.dart';
import 'package:water_bottle/water_bottle.dart';

class LiquidBottlePage extends StatefulWidget {
  final String title;
  final double waterLevel; // Nivel de agua recibido

  LiquidBottlePage({Key? key, required this.title, required this.waterLevel}) : super(key: key);

  @override
  _LiquidBottlePageState createState() => _LiquidBottlePageState();
}

class _LiquidBottlePageState extends State<LiquidBottlePage> {
  int selectedStyle = 0;
  late double _currentWaterLevel;

  @override
  void initState() {
    super.initState();
    _currentWaterLevel = widget.waterLevel; // Inicializar nivel de agua
  }

  @override
  Widget build(BuildContext context) {
    final plain = WaterBottle(
      waterColor: Colors.blue,
      bottleColor: Colors.lightBlue,
      capColor: Colors.blueGrey,
    );
    final sphere = SphericalBottle(
      waterColor: Colors.red,
      bottleColor: Colors.redAccent,
      capColor: Colors.grey.shade700,
    );
    final triangle = TriangularBottle(
      waterColor: Colors.lime,
      bottleColor: Colors.limeAccent,
      capColor: Colors.red,
    );

    final bottle = Center(
      child: SizedBox(
        width: 200,
        height: 300,
        child: selectedStyle == 0
            ? plain
            : selectedStyle == 1
                ? sphere
                : triangle,
      ),
    );

    final stylePicker = Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: Center(
        child: ToggleButtons(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Icon(Icons.crop_portrait),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Icon(Icons.circle_outlined),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Icon(Icons.change_history),
            ),
          ],
          isSelected: List<bool>.generate(3, (index) => index == selectedStyle),
          onPressed: (index) => setState(() => selectedStyle = index),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            bottle,
            Spacer(),
            stylePicker,
            Spacer(),
          ],
        ),
      ),
    );
  }

  void updateWaterLevel(double newLevel) {
    setState(() {
      _currentWaterLevel = newLevel;
    });
  }
}
